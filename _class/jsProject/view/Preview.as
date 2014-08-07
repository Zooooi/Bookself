package jsProject.view 
{
	
	import JsC.events.JEvent;
	import JsC.geom.Transforms;
	import JsC.mdel.SystemOS;
	
	import components.books.BookPage;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import jsProject.ctrl.PageDrag;
	
	import mx.core.UIComponent;
	
	
	[Event(name = "onProgress", type = "JsC.events.JEvent")]
	public class Preview extends Base
	{
		private var ui:UIComponent
		private var pageFilp:PageDrag
		private var pageContent:Sprite
		private var nTimer:Timer
		private var rectSprite:Sprite
		private var stageRect:Rectangle
		private var bitmap:Bitmap
		private var $mask:Sprite
		private var icon:Sprite
		private var bookPage:BookPage
		private var nOffset:uint
		
		private const nLineColor:uint = 0x666699
		private const nStroke:uint = 20
			
		private var nStageL:uint
		private var nStageT:uint
		
		
		public function Preview(_page:BookPage) 
		{
			xml = <root><preview width="250" height="150" line="4" lineColor="0x000000" rectLine="1" rectLineColor="0x333333" rectColor="0xFFFFFF" rectAlpha="0" blur="2.5"/></root>

			init(_page)
		}
		
		public function init(_page:BookPage):void
		{
			bookPage = _page
			ui = _page.getUI()
			if (!SystemOS.isMobile)
			{
				nOffset = 5
				filters =[new DropShadowFilter(5,45,0,0.5,5,5,0.5)]
			}
			ui.addChild(this)
			
			stageRect = _page.$getBookRect()
			nStageL = stageRect.x + 20
			nStageT = stageRect.y + 20
			pageFilp = _page.$getPageFilp()
			pageContent = pageFilp.getContent()
			
			var _bmd:BitmapData = new BitmapData(pageContent.width/pageContent.scaleX,pageContent.height/pageContent.scaleY, false, 0xffffff);
			_bmd.draw(pageContent)
			var _bmd2:BitmapData = new BitmapData(_bmd.width,_bmd.height, false, 0xffffff);
			_bmd2.draw(pageContent)
			
			bitmap = new Bitmap(_bmd)
			bitmap.smoothing = true
			bitmap.cacheAsBitmap = true
			if (!SystemOS.isMobile)bitmap.filters=[new BlurFilter(xml.preview.@blur,xml.preview.@blur,1)]
			
			var bitmap2:Bitmap = new Bitmap(_bmd)
			bitmap2.smoothing = true
			bitmap2.cacheAsBitmap = true
			
			Transforms.scaleRect([bitmap], new Rectangle(0, 0, xml.preview.@width, xml.preview.@height))
			Transforms.scaleRect([bitmap2], new Rectangle(0, 0, xml.preview.@width, xml.preview.@height))
			
			var back:Sprite 
			back = new Sprite()
			back.graphics.beginFill(0x000000,1)
			back.graphics.lineStyle(nStroke, nLineColor)
			back.graphics.drawRoundRect(0,0,bitmap.width,bitmap.height,nStroke/2,nStroke/2)
			back.graphics.drawRect(0,0,bitmap.width,bitmap.height)
			back.graphics.endFill()
			addChild(back)
			
			icon = new Sprite()
			icon.graphics.beginFill(0x000000,1)
			icon.graphics.lineStyle(nStroke/4, 0xffffff)
			icon.graphics.drawRoundRect(0,0,bitmap.width,bitmap.height,nStroke/4,nStroke/4)
			icon.graphics.drawRect(0,0,bitmap.width,bitmap.height)
			icon.graphics.endFill()
			addChild(icon)
			
			addChild(bitmap)
			addChild(bitmap2)
			
			rectSprite = new Sprite
			rectSprite.graphics.beginFill(0x000000, xml.preview.@rectAlpha)
			rectSprite.graphics.lineStyle(xml.preview.@rectLine,nLineColor)
			rectSprite.graphics.drawRect(0, 0, this.width - nOffset, this.height-5)
			rectSprite.graphics.endFill()
			rectSprite.useHandCursor = true
			addChild(rectSprite)
			
			$mask = new Sprite
			$mask.graphics.beginFill(xml.preview.@rectColor, xml.preview.@rectAlpha)
			$mask.graphics.lineStyle(xml.preview.@rectLine,xml.preview.@rectLineColor)
			$mask.graphics.drawRect(0, 0, this.width - nOffset, this.height - nOffset)
			$mask.graphics.endFill()
			addChild($mask) 
			
			
			bitmap2.mask = $mask
			
			nTimer = new Timer(50)
			nTimer.addEventListener(TimerEvent.TIMER, onMoving)
			nTimer.start()
			
			
			x = nStageL + stageRect.width - width   
			y = nStageT + stageRect.height - height 
			
			addEventListener(MouseEvent.MOUSE_DOWN,onIconMouseEvent)
			rectSprite.addEventListener(MouseEvent.MOUSE_DOWN,onRectMouseEvent)
			onMoving()
			
		}
		
		
		private function onMoving(evt:TimerEvent=null):void
		{
			var _x:Number = pageContent.width / bitmap.width
			var _y:Number = pageContent.height / bitmap.height
			var _L:Number = (pageContent.x - stageRect.x)/_x
			var _T:Number = (pageContent.y - stageRect.y)/_y
			var _W:Number = (pageContent.width / stageRect.width)
			var _H:Number = (pageContent.height / stageRect.height)
			rectSprite.x = Math.abs(_L)
			rectSprite.y = Math.abs(_T)
			rectSprite.width = bitmap.width / _W
			rectSprite.height =  bitmap.height / _H
			
		   	if (rectSprite.x > bitmap.width ) rectSprite.x = bitmap.width
			if (rectSprite.y > bitmap.height) rectSprite.y = bitmap.height
			if (rectSprite.width > bitmap.width )
			{
				rectSprite.x = 0
				rectSprite.width = bitmap.width
			}
			if (rectSprite.height > bitmap.height) 
			{
				rectSprite.y = 0
				rectSprite.height = bitmap.height
			}
			$mask.x = rectSprite.x
			$mask.y = rectSprite.y
			$mask.width = rectSprite.width
			$mask.height = rectSprite.height
		}
		
		private function onDraging():void
		{
			var _x:Number = rectSprite.width / stageRect.width
			var _y:Number = rectSprite.height / stageRect.height
			var _L:Number = (bitmap.x-rectSprite.x)/_x
			var _T:Number = (bitmap.y-rectSprite.y)/_y
			
			if (pageContent.width> stageRect.width)
			{
				pageContent.x = stageRect.x + _L
			}else{
				pageContent.x = stageRect.x + (stageRect.width - pageContent.width)/2
			}
			if (pageContent.height> stageRect.height)
			{
				pageContent.y = stageRect.y + _T
			}else{
				pageContent.y = stageRect.y + (stageRect.height - pageContent.height)/2 
			}
			
			
			bookPage.$stopMove()
			$mask.x = rectSprite.x
			$mask.y = rectSprite.y
			$mask.width = rectSprite.width
			$mask.height = rectSprite.height
		}
		
		
		
		private function onResize(evt:Event=null):void
		{
			ui.removeChild(this)
		}
		
		public function remove():void
		{
			nTimer.stop()
			parent.removeChild(this)
		}
		
		
		private function onRectMouseEvent(evt:MouseEvent) :void
		{
			dispatchEvent(new JEvent(JEvent.PROGRESS))
			switch (evt.type) 
			{
				case MouseEvent.MOUSE_DOWN:
					nTimer.stop()
					rectSprite.startDrag(false, new Rectangle(0, 0, bitmap.width - rectSprite.width, bitmap.height - rectSprite.height))
					ui.stage.addEventListener(MouseEvent.MOUSE_MOVE, onRectMouseEvent)
					ui.stage.addEventListener(MouseEvent.MOUSE_UP, onRectMouseEvent)
					break
				case MouseEvent.MOUSE_MOVE:
					onDraging()
					break
				case MouseEvent.MOUSE_UP:
					rectSprite.stopDrag()
					nTimer.start()
					ui.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onRectMouseEvent)
					ui.stage.removeEventListener(MouseEvent.MOUSE_UP, onRectMouseEvent)
					break
			}
		}
		
		private function onIconMouseEvent(evt:MouseEvent):void
		{
			if (evt.target==rectSprite)return
			dispatchEvent(new JEvent(JEvent.PROGRESS))
			switch (evt.type) 
			{
				case MouseEvent.MOUSE_DOWN:
					nTimer.stop()
					
					this.startDrag(false, new Rectangle(nStageL, nStageT, stageRect.width - width  , stageRect.height - height  ))
					ui.stage.addEventListener(MouseEvent.MOUSE_UP, onRectMouseEvent)
					break
				case MouseEvent.MOUSE_UP:
					this.stopDrag()
					nTimer.start()
					ui.stage.removeEventListener(MouseEvent.MOUSE_UP, onRectMouseEvent)
					break
			}
		}
		
	}

}