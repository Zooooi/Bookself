package JsC.draw
{
	import JsC.xml.XmlCtrl;
	
	import flash.display.Sprite;

	public class Drawer_drawArrow extends Drawer_drawBase
	{
		
		
		public function Drawer_drawArrow()
		{
			bFill = false
		}
		
		override public function setMode(_mode:String):void
		{
			super.setMode(_mode);
			switch(sMode)
			{
				case Drawer_type.drawArrow:
					currentFun = drawArrow1
					break;
					
				case Drawer_type.drawArrow2:
					currentFun = drawArrow2
					break;
			}
		}
		
		
		
		override public function drawing():void
		{
			currentFun()
		}
		
		private function drawArrow1():void
		{
			drawShape.graphics.clear()
			drawArrowWithVector(drawShape,nX,nY,drawSprite.mouseX,drawSprite.mouseY)
			
			createXML(sMode)
			addRectNode(nX,nY,drawSprite.mouseX,drawSprite.mouseY)
		}
		
		
		
		private function drawArrow2():void
		{
			drawShape.graphics.clear()
			drawArrowWithVector(drawShape,drawSprite.mouseX,drawSprite.mouseY,nX,nY,-30)
			drawArrowWithVector(drawShape,nX,nY,drawSprite.mouseX,drawSprite.mouseY)
			
			createXML(sMode)
			addRectNode(drawSprite.mouseX,drawSprite.mouseY,nX,nY,-30)
			addRectNode(nX,nY,drawSprite.mouseX,drawSprite.mouseY)
		}
		
		private function drawArrowWithVector(g:Sprite,x1:int,y1:int,x2:int,y2:int,_a:Number=30):void {
			//箭头长度
			var len:int = stroke*2 +30;
			//箭头与直线的夹角
			//var _a:int = 30;
			var angle:int = Math.atan2((y1-y2), (x1-x2))*(180/Math.PI);
			//angle = Degree.fixAngle(angle);
			g.graphics.lineStyle(stroke,strokeColor,strokeAlpha);
			g.graphics.moveTo(x2,y2);
			g.graphics.lineTo(x2+len*Math.cos((angle-_a)*(Math.PI/180)), y2+len*Math.sin((angle-_a)*(Math.PI/180)));
			g.graphics.moveTo(x2,y2);
			g.graphics.lineTo(x2+len*Math.cos((angle+_a)*(Math.PI/180)), y2+len*Math.sin((angle+_a)*(Math.PI/180)));
			g.graphics.moveTo(x1,y1);
			g.graphics.lineTo(x2,y2); 
		}
		
		override protected function drawOther(_xml:XML):void
		{
			drawArrowFromXML(_xml)
		}
		
		
		
		
		protected function drawArrowFromXML(_xml:XML):void
		{
			for (var i:int = 0; i < _xml.children().length(); i++) 
			{
				var _node:XML = XmlCtrl.getChildrenByID(XMLList(_xml),i)
				drawArrowWithVector(drawShape,_node.@x,_node.@y,_node.@width,_node.@height,_node.@angle)
			}
		}
		
	}
}