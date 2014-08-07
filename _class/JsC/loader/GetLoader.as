package JsC.loader{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import JsC.sys.JFiles;
	import JsC.sys.JObject;

	public class GetLoader extends LoaderBase {
		public var LoaderInfo:Array;
		
		private var nP:uint;
		private var aFile:Array;
		private var EventObject:Object;

		//......................................................................................主程序
		public function GetLoader(_file:*= undefined, _Obj:Object = undefined):void {
			if (_file) get(_file,_Obj);
		}
		public function get(_file:*, _Obj:Object = undefined):void
		{
			//.........................................................单文件下载(主程序于LoadBase里面)
			if (_file is String) {
				start(_file,_Obj);
			}
			//.........................................................多文件下载（以下是多文件下载程序的补充)
			if (_file is Array) {
				aFile=_file;
				EventObject=_Obj;
				nP=0;
				LoaderInfo=[];
				LoadAction(nP);
			}

		}
		private function GetLoaderComplete(event:Event):void
		{
			switch (LoaderInfo[nP].ext) {
				case ".xml" :
					LoaderInfo[nP].data=new XML(URLLoader(event.target).data);
					break;
				case ".swf" :
					LoaderInfo[nP].data=MovieClip(event.target.content);
					LoaderInfo[nP].object=event.target.loader.contentLoaderInfo.applicationDomain;
					break;
				case ".mp3" :
					LoaderInfo[nP].data=event.target;
					break;
				default :
					LoaderInfo[nP].data=event.target.content;
					break;
			}
			if (nP<aFile.length-1) {
				nP++;
				LoadAction(nP);
			} else {
				dispatchEvent(new Event("AllComplete"));
			}
		}
		private function LoadAction(_Num:uint):void
		{
			LoaderInfo[_Num]=JObject.cloneObject(start(aFile[_Num],EventObject));
			dispatcher.addEventListener(Event.COMPLETE,GetLoaderComplete);
		}
	}
}