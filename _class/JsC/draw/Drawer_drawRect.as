package JsC.draw
{
	public class Drawer_drawRect extends Drawer_drawBase
	{
		public function Drawer_drawRect()
		{
			bFill = true
		}
		
		override public function drawing():void
		{
			drawShape.graphics.clear()
			drawShape.graphics.beginFill(fillColor, fillAlpha);
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			drawShape.graphics.drawRect(nX,nY,drawSprite.mouseX-nX,drawSprite.mouseY-nY)
			drawShape.graphics.endFill()
			
			createXML(sMode)
			addPointNode(nX,nY)
			addPointNode(nX+(drawSprite.mouseX-nX),nY)
			addPointNode(nX+(drawSprite.mouseX-nX),nY+(drawSprite.mouseY-nY))
			addPointNode(nX,nY+(drawSprite.mouseY-nY))
		}
		
	}
}