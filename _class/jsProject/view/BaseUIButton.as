package jsProject.view
{
	import JsC.events.JEvent;
	import JsC.shell.ShellSystem;
	
	import components.books.BookPage;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import jsProject.mdel.Viewers;
	
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	
	import spark.components.Group;

	[Event(name="CLICK", type="JsC.events.JEvent")]
	public class BaseUIButton extends Sprite
	{
		protected var bgBtn:SimpleButton
		private var nMouseX:Number
		private var nMouseY:Number
		protected var bDrag:Boolean
		private var _parent:IVisualElement
		private var nRect:Rectangle
		
		protected var xList:XMLList
		
		protected const cW:uint = 58
		protected const cH:uint = 58
		
		public function BaseUIButton()
		{
			mouseEnabled = true
			mouseChildren = true
			useHandCursor = true
			buttonMode = true
		}
		
		
		
		protected function onMouseEvent(event:MouseEvent):void
		{
			Viewers.getPage().$stopMove()
			switch(event.type)
			{
				case MouseEvent.MOUSE_DOWN:
					nMouseX = stage.mouseX
					nMouseY = stage.mouseY
					bDrag = false
					nRect = new Rectangle(width*2,height*2,parent.parent.width-width*4,parent.parent.height-height*4)
					stage.addEventListener(MouseEvent.MOUSE_UP,onStageMouseEvent)
					startDrag(false,nRect)
					xList.@x = x
					xList.@y = y
					break;
			}
		}
		
		protected function onStageMouseEvent(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_UP:
					stopDrag()
					stage.removeEventListener(MouseEvent.MOUSE_UP,onStageMouseEvent)
					if (Math.abs(stage.mouseX-nMouseX)>3 || Math.abs(stage.mouseY-nMouseY)>3)
					{
						bDrag = true
						xList.@x = x
						xList.@y = y
						ShellSystem.current.saveUserFile()
					}else{
						dispatchEvent(new JEvent(JEvent.CLICK))
					}
					break;
			}
		}
		
		protected function onStageMouseEvent2(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_UP:
					Viewers.getPage().addButton(this)
					nRect = new Rectangle(width*2,height*2,parent.width-width*4,parent.height-height*4)
					stage.removeEventListener(MouseEvent.MOUSE_UP,onStageMouseEvent2)
					addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent)
					stopDrag()
					/*if (x<nRect.x)
					{
						x = nRect.x
					}else if (x>nRect.x + nRect.width){
						x = nRect.x + nRect.width
					}
					if (y<nRect.y){
						y = nRect.y
					}else if(y>nRect.y + nRect.height){
						y = nRect.y + nRect.height
					}*/
					xList.@x = x
					xList.@y = y
					ShellSystem.current.saveUserFile()
					break;
			}
		}
		
		
		public function $newAction():void
		{
			xList.@x = x
			xList.@y = y
			startDrag(false)
			var _time:Timer = new Timer(20)
			_time.addEventListener(TimerEvent.TIMER,onNewActionStageEvent)
			_time.start()
		}
		
		protected function onNewActionStageEvent(event:TimerEvent):void
		{
			if (stage!=null)
			{
				setTimeout(ondelay,300)
				var _time:Timer = Timer(event.currentTarget)
				_time.stop()
			}
		}
		
		public function $LoadAction():void
		{
			addEventListener(Event.ADDED_TO_STAGE,onEvent)
		}
		
		protected function onEvent(event:Event):void
		{
			x = xList.@x
			y = xList.@y
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent)
		}
		
		private function ondelay():void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP,onStageMouseEvent2)
		}
		
		
		public function $setData(_xmlList:XMLList):void
		{
			xList = _xmlList
			x = _xmlList.x
			y = _xmlList.y
		}
		public function $getData():XMLList
		{
			return xList
		}
		
		public function setPageNo(_page:uint):void
		{
			xList.@page = _page + 1
		}
		
		public function $compareAndDestroy(_xmlList:XMLList):Boolean
		{
			var _b:Boolean
			if (xList == _xmlList)
			{
				Sprite(parent).removeChild(this)
				_b = true
			}
			return _b
		}
		
		
	}
}