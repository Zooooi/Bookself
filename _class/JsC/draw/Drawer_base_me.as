package JsC.draw
{
	import flash.display.Sprite;
	
	
	//Move & Erase
	public class Drawer_base_me extends Drawer_base
	{
		
		protected var cP:uint = 3
		public function Drawer_base_me()
		{
			
		}
		
		public function setTarget(drawShape:Sprite):void
		{
			drawSprite = drawShape
			stage = drawSprite.stage
		}
		
		protected function hitTest_Mouse():Boolean
		{
			return drawShape.hitTestPoint(stage.mouseX,stage.mouseY,true) ||
				drawShape.hitTestPoint(stage.mouseX+cP,stage.mouseY+cP,true) ||
				drawShape.hitTestPoint(stage.mouseX-cP,stage.mouseY-cP,true) ||
				drawShape.hitTestPoint(stage.mouseX+cP,stage.mouseY-cP,true) ||
				drawShape.hitTestPoint(stage.mouseX-cP,stage.mouseY+cP,true)
		}
		
	}
}