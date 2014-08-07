package JsC.draw
{
	import JsC.events.JEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	[Event(name="REMOVE", type="JsC.events.JEvent")]
	public class Drawer_earse extends Drawer_base_me
	{
		public function Drawer_earse()
		{
			super();
		}
		
		public function catchAndEarse():void
		{
			nX = drawSprite.mouseX
			nY = drawSprite.mouseY
			onEarsing()
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onEarsing)
			stage.addEventListener(MouseEvent.MOUSE_UP,onEarseEnd)
		}
		
		
		private function onEarsing(event:MouseEvent=null):void
		{
			var _b:Boolean
			if (event==null )
			{
				_b = true
			}else if (Math.abs(drawSprite.mouseX-nX)>1 || Math.abs(drawSprite.mouseY-nY)>1)
			{
				nX = drawSprite.mouseX
				nY = drawSprite.mouseY
				_b = true
			}
			
			if (_b)
			{
				var i:int
				for (i = drawSprite.numChildren-1; i>=0 ; i--) 
				{
					drawShape = Sprite(drawSprite.getChildAt(i))
					if (hitTest_Mouse())
					{
						var _event:JEvent = new JEvent(JEvent.REMOVE)
						_event._id = i
						dispatchEvent(_event)
						break
					}
					
				}
			}
			
		}
		
		
		protected function onEarseEnd(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onEarsing)
			stage.removeEventListener(MouseEvent.MOUSE_UP,onEarseEnd)
			dispatchEvent(new JEvent(JEvent.END))
		}
	}
}