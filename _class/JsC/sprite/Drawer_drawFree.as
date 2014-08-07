package JsC.sprite
{
	import flash.display.Sprite;
	
	public class Drawer_drawFree extends Drawer_drawBase
	{
		public function Drawer_drawFree()
		{
			bFill = false
		}
		
		override public function drawStart():void
		{
			super.drawStart();
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			drawShape.graphics.moveTo(drawSprite.mouseX,drawSprite.mouseY)
			createXML(sMode)
			addPointNode(drawSprite.mouseX,drawSprite.mouseY)
		}
		
		override public function drawing():void
		{
			super.drawing();
			if (Math.abs(drawSprite.mouseX-nX)>2 || Math.abs(drawSprite.mouseY-nY)>2)
			{
				nX = drawSprite.mouseX
				nY = drawSprite.mouseY
				drawShape.graphics.lineTo(drawSprite.mouseX,drawSprite.mouseY)
				addPointNode(drawSprite.mouseX,drawSprite.mouseY)
			}
		}
		
		
		
		
	}
}