package jsProject.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class IconBitmap extends Sprite
	{
		private var nW:uint
		private var nH:uint
		public function IconBitmap(_url:String,_w:uint,_h:uint)
		{
			nW = _w
			nH = _h
			loadPic(_url)
		}
		
		private function loadPic(_url:String):void
		{
			var request:URLRequest=new URLRequest(_url);
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadPicError)
			loader.load(request);
		}
		
		private function completeHandler(event:Event):void 
		{
			
			var bmp:Bitmap=Bitmap(event.target.content);
			bmp.smoothing = true
			bmp.cacheAsBitmap = true
			bmp.width = nW
			bmp.height = nH
			addChild(bmp)
		}
		
		protected function onLoadPicError(event:IOErrorEvent):void
		{
			var _text:TextField = new TextField
			var _content:String = String(event)
			_content = _content.replace("URL:","\r\n")
			_text.text = _content
			_text.autoSize = TextFieldAutoSize.LEFT
			addChild(_text)
			trace(event)
		}
	}
}