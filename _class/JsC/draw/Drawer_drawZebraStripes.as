package JsC.draw
{
	import flash.geom.Point;

	public class Drawer_drawZebraStripes extends Drawer_drawBase
	{
		public function Drawer_drawZebraStripes()
		{
			bFill = false
		}
		
		override public function drawing():void
		{
			super.drawing();
			var _w:uint = stroke/4
			var _h:uint = stroke*2
			var beginPoint:Point = new Point(nX,nY)
			var endPoint:Point = new Point(drawSprite.mouseX,drawSprite.mouseY)
			var Ox:Number = beginPoint.x;
			var Oy:Number = beginPoint.y;
			
			var totalLen:Number = Point.distance(beginPoint, endPoint);
			var currLen:Number = 0;
			var halfWidth:Number = _w * .5;
			
			var radian:Number = Math.atan2(endPoint.y - Oy, endPoint.x - Ox);
			var radian1:Number = (radian / Math.PI * 180 + 90) / 180 * Math.PI;
			var radian2:Number = (radian / Math.PI * 180 - 90) / 180 * Math.PI;
			
			var currX:Number, currY:Number;
			var p1x:Number, p1y:Number;
			var p2x:Number, p2y:Number;
			
			drawShape.graphics.clear()
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			
			createXML(sMode)
			while (currLen <= totalLen)
			{
				currX = Ox + Math.cos(radian) * currLen;
				currY = Oy + Math.sin(radian) * currLen;
				p1x = currX + Math.cos(radian1) * halfWidth;
				p1y = currY + Math.sin(radian1) * halfWidth;
				p2x = currX + Math.cos(radian2) * halfWidth;
				p2y = currY + Math.sin(radian2) * halfWidth;
				
				drawShape.graphics.moveTo(p1x, p1y);
				drawShape.graphics.lineTo(p2x, p2y);
				
				addPointNode(p1x,p1y)
				addPointNode(p2x,p2y)
				currLen += _h;
			}
		}
		
		
	}
}