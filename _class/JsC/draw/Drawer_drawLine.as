package JsC.draw
{
	import flash.display.BlendMode;
	import flash.display.Sprite;

	public class Drawer_drawLine extends Drawer_drawBase
	{
		public function Drawer_drawLine()
		{
			bFill = false
		}
		
		override public function setMode(_mode:String):void
		{
			super.setMode(_mode);
			switch(sMode)
			{
				case Drawer_type.drawLine:
					currentFun = drawLine
					break;
				
				case Drawer_type.drawNite:
					currentFun = drawNite
					break;
			}
		}
		
		override public function drawStart():void
		{
			super.drawStart();
			switch(sMode)
			{
				case Drawer_type.drawLine:
					break;
				
				case Drawer_type.drawNite:
					drawShape.blendMode = BlendMode.MULTIPLY
					drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
					drawShape.graphics.moveTo(drawSprite.mouseX,drawSprite.mouseY)
					break;
			}
			
			
		}
		
		
		override public function drawing():void
		{
			currentFun()
		}
		
		public function drawLine():void
		{
			super.drawing();
			
			drawShape.graphics.clear()
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			drawShape.graphics.moveTo(nX,nY)
			drawShape.graphics.lineTo(drawSprite.mouseX,drawSprite.mouseY)
			
			createXML(sMode)
			addPointNode(nX,nY)
			addPointNode(drawSprite.mouseX,drawSprite.mouseY)
		}
		
		private function drawNite():void
		{
			super.drawing();
			drawShape.graphics.lineTo(drawSprite.mouseX,nY)
				
			createXML(sMode)
			addPointNode(nX,nY)
			addPointNode(drawSprite.mouseX,nY)
		}
	}
}