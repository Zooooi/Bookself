package JsC.loader{
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;

	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import flash.display.Loader;
	import flash.display.MovieClip;

	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class LoaderBase extends EventDispatcher {
		private var request:URLRequest;
		private var file:Object=new Object();
		private var extObj:*;
		private var LoaderEvent:Object;
		protected var dispatcher:IEventDispatcher;

		//......................................................................................(下载)
		protected function start(_file:String=null,_Obj:Object=undefined):Object {
			LoaderEvent=_Obj;
			var _indexNum:uint;
			if (_file.lastIndexOf("/")==-1) {
				_indexNum=0;
			} else {
				_indexNum=_file.lastIndexOf("/")+1;
			}
			file.path=_file;
			file.ext=_file.substring(_file.lastIndexOf("."),_file.length);
			file.name=_file.substring(_indexNum,_file.lastIndexOf("."));

			resume();
			_loadFile();
			return file;
		}
		//......................................................................................(停止)
		public function stop():void
		{
			extObj.unload();
		}
		//......................................................................................(还原)
		public function resume():void 
		{
			request = new URLRequest(file.path);	
		}
		//......................................................................................分类下载
		private function _loadFile() :void
		{
			try {
				switch (file.ext) {
					case ".xml" :
						extObj=new URLLoader();
						dispatcher=extObj;
						break;
					case ".mp3" :
						extObj = new Sound();
						dispatcher=extObj;
						break;
					default :
						extObj=new Loader();
						dispatcher=extObj.contentLoaderInfo;
						break;
				}
				_addListenersAction(LoaderEvent);
				extObj.load(request);
			} catch (error:Error) {
				loaderror();
			}
		}
		
		public function removeEvent():void
		{
			_addListenersAction(LoaderEvent,"removeEventListener")
		}

		//......................................................................................分类侦听
		private function _addListenersAction(_Obj:Object, _Event:String = "addEventListener"):void
		{
			
			for (var nP:String in _Obj) {
				var bAddEvent:Boolean=true;
				var _Func:Function;
				if (_Obj[nP]==true) {
					_Func=this[nP];
				}
				if (_Obj[nP] is Function) {
					_Func=_Obj[nP];
				}
				var _Status:String;

				switch (nP) {
					case "init" :
						_Status=Event.INIT;
						break;
					case "open" :
						_Status=Event.OPEN;
						break;
					case "httpstatus" :
						_Status=HTTPStatusEvent.HTTP_STATUS;
						break;
					case "complete" :
						_Status=Event.COMPLETE;
						break;
					case "ioerror" :
						_Status=IOErrorEvent.IO_ERROR;
						break;
					case "progress" :
						_Status=ProgressEvent.PROGRESS;
						break;
					case "unload" :
						_Status=Event.UNLOAD;
						break;
					default :
						bAddEvent=false;
				}
				if (bAddEvent) {
					dispatcher[_Event](_Status,_Func);
				}
			}
		}
		//......................................................................................预设侦听
		private function init(event:Event):void {
			trace("initHandler: " + event);
		}
		private function progress(event:ProgressEvent):void {
			trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}
		private function complete(event:Event):void {
			trace("completeHandler: " + event);
		}
		private function httpstatus(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		private function ioerror(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}
		private function open(event:Event):void {
			trace("openHandler: " + event);
		}
		private function unload(event:Event):void {
			trace("unLoadHandler: " + event);
		}
		private function loaderror():void {
			trace("Unable to load requested document.");
		}

	}


}