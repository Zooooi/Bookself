package jsProject.view
{
	import JsC.events.JEvent;
	import JsC.mdel.SystemOS;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	

	public class IconButtonSprite extends Base
	{
		protected var btn:SimpleButton
		private var nCount:uint
		private var sPath:String
		private var aBitmap:Vector.<Bitmap> = new Vector.<Bitmap>
		public var index:uint
		public var bSelect:Boolean
		
		private var nLocRect:Rectangle
		private var xmlNode:XML
		
		public function IconButtonSprite()
		{
			
		}
		
		public function $setData(_path:String,_xml:String):void
		{
			nCount = 0
			xml = new XML(_xml)
				
			sPath = _path
			btn = new SimpleButton
			btn.enabled = true
			btn.useHandCursor = true
			addChild(btn)
				
			loadPict()
		}
		
		
		
		protected function loadPict():void
		{
			
			if (nCount <  xml.files.children().length())
			{
				JsLoader.get(sPath + xml.files.children()[nCount], {complete:onComplete,ioError:onContinue})
			}else {
				var _evt:JEvent = new JEvent(JEvent.COMPLETE)
				_evt.$setString(xml.localName())
				_evt.$setObject(btn)
				dispatchEvent(_evt)
			}
		}
		
		private function onComplete(evt:Event):void
		{
			var _bitmap:Bitmap = Bitmap(evt.target.content) 
			_bitmap.smoothing = true
			aBitmap.push(_bitmap)
			switch (nCount) 
			{
				case 0:
					btn.upState = _bitmap
					btn.overState = _bitmap
					btn.downState = _bitmap
					btn.hitTestState = btn.upState;
					break;
				case 1:
					select(bSelect)
					btn.overState = _bitmap
					break;
				case 2:
					btn.downState = _bitmap
					break;
			}
		
			if (nLocRect!=null)
			{
				x =  nLocRect.x
				y =  nLocRect.y
				btn.width = nLocRect.width
				btn.height = nLocRect.height
			}else{
				x =  xml.@x
				y =  xml.@y
				btn.width = uint(xml.@width)
				btn.height = uint(xml.@height)
			}
			onContinue()
		}
		
		
		public function $setLoc(_x:Number,_y:Number,_w:Number,_h:Number):void
		{
			nLocRect = new Rectangle
			nLocRect.x = _x
			nLocRect.y = _y
			nLocRect.width = _w
			nLocRect.height = _h	
		}
		
		
		public function $setXML(_xml:XML):void
		{
			xmlNode = _xml
			$setLoc(xmlNode.@x,xmlNode.@y,xmlNode.@width,xmlNode.@height)
		}
		
		
		public function $getXML():XML
		{
			return xmlNode
		}
		
		public function getSelected():Boolean
		{
			return bSelect
		}
		
		
		public function select(_b:Boolean):void
		{
			bSelect =_b
			if (aBitmap.length==0)return
			if (_b)
			{
				btn.upState = aBitmap[1]
				if (SystemOS.PC)
				{
					btn.overState = aBitmap[1]
				}else{
					btn.overState = aBitmap[0]
				}
				btn.downState = aBitmap[0]
			}else{
				btn.upState = aBitmap[0]
				if (SystemOS.PC)
				{
					btn.overState = aBitmap[0]
				}else{
					btn.overState = aBitmap[1]
				}
				btn.downState = aBitmap[1]
			}
			
		}
		
		
		private function onContinue(evt:IOErrorEvent=null):void
		{
			nCount++
			loadPict()
			if (evt)
			{
				trace("IconButtonsprite" ,sPath + xml.files.children()[nCount],evt)
			}
		}
		
	}
}