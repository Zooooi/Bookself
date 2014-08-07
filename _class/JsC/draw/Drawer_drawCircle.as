package JsC.draw
{
	public class Drawer_drawCircle extends Drawer_drawBase
	{
		public function Drawer_drawCircle()
		{
			bFill = true
		}
		
		override public function drawing():void
		{
			drawShape.graphics.clear()
			drawShape.graphics.beginFill(fillColor, fillAlpha);
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			drawShape.graphics.drawEllipse(nX,nY,drawSprite.mouseX-nX,drawSprite.mouseY-nY)
			drawShape.graphics.endFill()
			
			createXML(sMode)
			addRectNode(nX,nY,drawSprite.mouseX-nX,drawSprite.mouseY-nY)
		}
		
		
	}
}