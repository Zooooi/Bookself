package JsC.draw
{
	import JsC.events.JEvent;
	import JsC.xml.XmlCtrl;
	
	import flash.display.Sprite;
	
	public class Drawer_drawBase extends Drawer_base_dr
	{
		protected var currentFun:Function
		
		public function Drawer_drawBase()
		{
		}
		
		override public function setDrawTargets(_sprite:Sprite,_hitLayer:Sprite,_useXML:Boolean = true):void
		{
			super.setDrawTargets(_sprite,_hitLayer,_useXML)
			drawShape = new Sprite
			drawSprite.addChild(drawShape)
		}
		
		override public function drawFromXML(_sprite:Sprite, _xml:XML):void
		{
			super.drawFromXML(_sprite, _xml);
			drawShape = new Sprite
			drawSprite.addChild(drawShape)
			if (_xml.@x!=undefined)drawShape.x = _xml.@x
			if (_xml.@y!=undefined)drawShape.y = _xml.@y
			if (bFill)drawShape.graphics.beginFill(fillColor, fillAlpha)
			drawShape.graphics.lineStyle(stroke,strokeColor,strokeAlpha)
			var _blendMode:String = String(_xml.@blendMode)
			if (_blendMode!="")drawShape.blendMode = _blendMode
			var _type:String = _xml.@shape
			switch(_type)
			{
				default:
				case Drawer_type.drawingFree:
				case Drawer_type.drawNite:
				case Drawer_type.drawLine:
				case Drawer_type.drawingRect:
				case Drawer_type.drawDelta:
					drawingPoint(_xml)
					break;
				case Drawer_type.drawZebraStripes:
					drawZebraStripes(_xml)
					break
				case Drawer_type.drawCircle:
					drawCircle(_xml)
					break
				case Drawer_type.drawArrow:
				case Drawer_type.drawArrow2:
					drawOther(_xml)
					break
			}
			if (bFill)drawShape.graphics.endFill();
		}
		
		
		protected function drawOther(_xml:XML):void
		{
			
		}
		
		protected function drawingPoint(_xml:XML):void
		{
			for (var i:int = 0; i < _xml.children().length(); i++) 
			{
				var _node:XML = XmlCtrl.getChildrenByID(XMLList(_xml),i)
				if (i==0)
				{
					drawShape.graphics.moveTo(_node.@x,_node.@y)
				}else{
					drawShape.graphics.lineTo(_node.@x,_node.@y)
				}
			}
		}
		
		
		protected function drawZebraStripes(_xml:XML):void
		{
			for (var i:int = 0; i < _xml.children().length(); i++) 
			{
				var _node:XML = XmlCtrl.getChildrenByID(XMLList(_xml),i)
				if (i%2==0)
				{
					drawShape.graphics.moveTo(_node.@x,_node.@y)
				}else{
					drawShape.graphics.lineTo(_node.@x,_node.@y)
				}
			}
		}
		
		protected function drawCircle(_xml:XML):void
		{
			var _node:XML = XmlCtrl.getChildrenByID(XMLList(_xml),0)
			drawShape.graphics.drawEllipse(_node.@x,_node.@y,_node.@width,_node.@height)
		}
		
		
		
		public function setMode(_mode:String):void
		{
			sMode = _mode
		}
		
		public function moveTo(_x:Number,_y:Number):void
		{
			drawShape.graphics.moveTo(_x,_y)
		}
		
		public function drawStart():void
		{
			nX = drawSprite.mouseX
			nY = drawSprite.mouseY
		}
		
		
		public function drawing():void
		{
			
		}
		
		
		public function drawingWithMouse():void
		{
			if (drawHitTest.mouseX>0 && drawHitTest.mouseY>0 && drawHitTest.mouseX<nW && drawHitTest.mouseY<nH ) 
			{
				drawing()
			}else{
				var _x:Number = drawSprite.mouseX
				var _y:Number = drawSprite.mouseY
				if (_x > nW)
				{
					_x = nW
				}else if (_x < nX){
					_x = nX
				}
				if (_y > nH)
				{
					_y = nH
				}else  if (_y < nY){
					_y = nY
				}
				moveTo(_x,_y)
			}
			
			
		}
		
		public function drawEnd():void
		{
			if (drawShape.width<2 && drawShape.height<2)
			{
				drawSprite.removeChild(drawShape)
			}else{
				dispatchEvent(new JEvent(JEvent.END))
			}
		}
		
		
	}
}