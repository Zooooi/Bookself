package JsC.draw
{
	import JsC.events.JEvent;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Drawer_move extends Drawer_base_me
	{
		private var nCurrentNodeNumber:uint
		
		public function Drawer_move()
		{
			
		}
		
		
		public function setMoveRect(_x:Number,_y:Number,_w:Number,_h:Number):void
		{
			nX = _x
			nY = _y
			nW = _w
			nH = _h
		}
		
		public function catchAndMove():void
		{
			var i:int
			for (i = drawSprite.numChildren-1; i>=0 ; i--) 
			{
				drawShape = Sprite(drawSprite.getChildAt(i))
				if (hitTest_Mouse())
				{
					nCurrentNodeNumber = i
					var _rect:Rectangle = drawShape.getRect(drawShape)
					var _x:Number = -_rect.x + 10
					var _y:Number = -_rect.y + 10
					var _w:Number = nW - _rect.width - 10
					var _h:Number = nH- _rect.height - 10
					_rect = new Rectangle(_x,_y,_w,_h)
					drawShape.startDrag(false,_rect)
					stage.addEventListener(MouseEvent.MOUSE_UP,onMoveEnd)
					break
				}
			}
		}
		
		protected function onMoveEnd(event:MouseEvent):void
		{
			drawShape.stopDrag()
			var _event:JEvent = new JEvent(JEvent.END)
			_event._id = nCurrentNodeNumber
			_event._x = drawShape.x
			_event._y = drawShape.y
			dispatchEvent(_event)
		}
	}
}