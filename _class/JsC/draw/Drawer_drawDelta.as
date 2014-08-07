package JsC.draw
{
	import flash.geom.Point;

	public class Drawer_drawDelta extends Drawer_drawBase
	{
		public function Drawer_drawDelta()
		{
			bFill = true
		}
		
		override public function drawing():void
		{
			var r:uint=Math.sqrt(Math.pow(nX-drawSprite.mouseX,2)+Math.pow(nY-drawSprite.mouseY,2))
			var Q:Number=60*(2*Math.PI/360);//这里得到是弧度，即30度对应的弧度数
			//画三角形
			var aP:Point = new Point(nX, nY-r)
			var bP:Point = new Point(nX + r * Math.sin(Q), nY + r/2);
			var cP:Point = new Point(nX - r * Math.sin(Q), nY + r/2);
			var _b:Boolean
			var _i:uint = 2
			if (aP.y<_i) 
			{
				_b = true
			}else if (cP.x<_i || bP.x > nW-_i)
			{
				_b = true
			}else if (cP.y>nH-_i || bP.y>nH-_i)
			{
				_b = true
			}
			if (_b)return 
				
			drawShape.graphics.clear()
			drawShape.graphics.beginFill(fillColor, fillAlpha);
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			drawShape.graphics.moveTo(aP.x, aP.y);
			drawShape.graphics.lineTo(bP.x, bP.y)
			drawShape.graphics.lineTo(cP.x, cP.y)
			drawShape.graphics.lineTo(aP.x, aP.y);
			
			createXML(sMode)
			addPointNode(nX, nY-r)
			addPointNode(nX + r * Math.sin(Q), nY + r/2);
			addPointNode(nX - r * Math.sin(Q), nY + r/2);
			addPointNode(nX, nY-r);
		}
		
		
	}
}