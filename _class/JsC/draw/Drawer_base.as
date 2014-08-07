package JsC.draw
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	[Event(name="END", type="JsC.events.JEvent")]
	public class Drawer_base extends EventDispatcher
	{
		protected var drawSprite:Sprite
		protected var drawShape:Sprite
		protected var drawHitTest:Sprite
		protected var stage:Stage
		
		protected var nX:Number
		protected var nY:Number
		protected var nW:Number
		protected var nH:Number
		
		
		public function Drawer_base()
		{
			
		}
		
		
	}
}