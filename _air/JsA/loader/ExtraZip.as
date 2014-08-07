package JsA.loader
{
	import JsC.events.JEvent;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipErrorEvent;
	import deng.fzip.FZipEvent;
	import deng.fzip.FZipFile;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	
	[Event(name="PROGRESS", type="JsC.events.JEvent")]
	[Event(name="COMPLETE", type="JsC.events.JEvent")]
	[Event(name="ALLCOMPLETE", type="JsC.events.JEvent")]
	
	
	public class ExtraZip extends EventDispatcher
	{
		private var zip:FZip
		private var nCount:uint;
		private var nLength:uint;
		private var zipPath:String
		private var bPass:Boolean
		public function ExtraZip()
		{
			zip = new FZip
			zip.addEventListener(Event.OPEN,onOpen)
			zip.addEventListener(FZipErrorEvent.PARSE_ERROR,onZipError)
			zip.addEventListener(ProgressEvent.PROGRESS,onProgress)
			zip.addEventListener(IOErrorEvent.IO_ERROR,onIoError)
			zip.addEventListener(FZipEvent.FILE_LOADED,onZipLoadSuccess)
		}
		
		
		protected function onOpen(event:Event):void
		{
			trace(this,event.type,event)
		}		
		
		
		
		public function start(zipfile:String,path:String):void
		{
			zipPath = path;
			zip.addEventListener(Event.COMPLETE,onZipLoaded)
			zip.load(new URLRequest(zipfile));
		}
		
		public function startByStep(zipfile:String,path:String):void
		{
			zipPath = path;
			zip.addEventListener(Event.COMPLETE,onZipLoaded2)
			zip.load(new URLRequest(zipfile));
		}
		
		protected function onZipLoadSuccess(event:FZipEvent):void
		{
			trace(this,event.type,event)
		}
		
		protected function onIoError(event:IOErrorEvent):void
		{
			trace(this,event.type,event)
		}
		
		protected function onProgress(event:ProgressEvent):void
		{
			var _event:JEvent = new JEvent(JEvent.PROGRESS)
			_event._x = event.bytesLoaded
			_event._y = event.bytesTotal
			dispatchEvent(_event);
			//trace(this,event.bytesLoaded,event.bytesTotal)
		}
		
		protected function onZipError(event:FZipErrorEvent):void
		{
			trace(this,event.type,event)
		}
		
		protected function onZipLoaded(event:Event):void
		{
			trace(this,event.type)
			var _zip:FZip = FZip(event.currentTarget)
			nCount = 0;
			nLength = _zip.getFileCount()
			unzip(_zip)
		}
		
		protected function onZipLoaded2(event:Event):void
		{
			trace(this,event.type)
			var _zip:FZip = FZip(event.currentTarget)
			nCount = 0;
			nLength = _zip.getFileCount()
			bPass = false
			unzip2(_zip)
		}
		
		private function unzip(_zip:FZip):void
		{
			for(var i:int=0; i<_zip.getFileCount(); i++)
			{
				var _one:FZipFile = _zip.getFileAt(i);
				if (_one.filename.indexOf("/.")<0 && _one.filename.lastIndexOf("/")!=_one.filename.length-1)
				{
					var _file:File = new File(zipPath + _one.filename)
					trace(i,_file.url)
					if (!_file.exists)
					{
						var bytes:ByteArray = _one.content as ByteArray;    
						var fs:FileStream = new FileStream(); 
						fs.openAsync(_file, FileMode.WRITE);    
						fs.position = 0;    
						fs.writeBytes(bytes, 0, bytes.length);    
						fs.addEventListener(Event.COMPLETE, function (event:Event):void {    
							fs.close();    
						});    
						fs.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent):void {    
							fs.close();    
						}); 
					}
				}
				
			}
			zip.close()
		}
		
		private function unzip2(_zip:FZip):void
		{
			if (bPass)return
			if(nCount<nLength)
			{
				var _one:FZipFile = _zip.getFileAt(nCount);
				var _t:uint = 22
				if (_one.filename.indexOf("/.")<0 && _one.filename.lastIndexOf("/")!=_one.filename.length-1)
				{
					var _file:File = new File(zipPath + _one.filename)
					
					var bytes:ByteArray = _one.content as ByteArray;    
					var fs:FileStream = new FileStream(); 
					/*fs.addEventListener(Event.COMPLETE, function (event:Event):void {  
						trace(fs,event)
						fs.close();    
					});    
					fs.addEventListener(IOErrorEvent.IO_ERROR, function (event:IOErrorEvent):void {    
						trace(fs,event)
						fs.close();    
					}); 
					_file.addEventListener(Event.COMPLETE,function(event:Event):void
					{
						trace(_file,event);
					});*/
					_t = Math.round(bytes.length / 5000);
					fs.openAsync(_file, FileMode.WRITE);    
					fs.position = 0;    
					fs.writeBytes(bytes, 0, bytes.length); 
				}
				_t = (_t>100)?100:_t;
				var _event:JEvent = new JEvent(JEvent.COMPLETE)
				_event._x = nCount + 1
				_event._y = nLength
				dispatchEvent(_event)
				nCount++
				setTimeout(unzip2,_t,_zip);
			}else{
				dispatchEvent(new JEvent(JEvent.ALLCOMPLETE));
				zip.close()
			}
		}
		
		
		public function close():void
		{
			bPass = true
			zip.close()
		}
		
		
		
	}
}