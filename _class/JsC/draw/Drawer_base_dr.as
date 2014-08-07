package JsC.draw
{
	import JsC.xml.XmlCtrl;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	//畫
	public class Drawer_base_dr extends Drawer_base
	{
		protected const XML_drawXML:XML=<drawing/>;
		protected const XML_drawNode:XML=<draw shape="" fillColor="" fillAlpha="" stroke="" strokeAlpha="" blendMode=""/>;
		protected const XML_drawShape:XML=<shape x="" y="" width="" height=""/>;
		protected const XML_drawPoint:XML=<point x="" y=""/>;
		
	
		protected var bFill:Boolean
		
		protected var sMode:String
		protected var bUseXML:Boolean
		
		protected var nMouseX:Number
		protected var nMouseY:Number
		
		protected var xmlDrawer:XML
		protected var xmlShape:XML
		protected var xmlNode:XML
		
		public var fillColor:uint = 0
		public var fillAlpha:Number = 0.5
		public var strokeColor:uint = 0x000000
		public var strokeAlpha:Number = 1
		public var stroke:uint = 1
		
		public function Drawer_base_dr()
		{
			
		}
		
		public function setDrawRect(_x:Number,_y:Number,_w:Number,_h:Number):void
		{
			nX = _x
			nY = _y
			nW = _w
			nH = _h
		}
		
		public function setDrawTargets(_sprite:Sprite,_hitLayer:Sprite,_useXML:Boolean = true):void
		{
			drawSprite = _sprite
			drawHitTest = _hitLayer
			stage = drawSprite.stage
			bUseXML = _useXML
		}
		
	
		
		
		
		public function drawFromMouse(_hitLayer:Sprite=null):void
		{
			if (_hitLayer) drawHitTest = _hitLayer
		}
		
		
		public function drawFromXML(_sprite:Sprite,_xml:XML):void
		{
			drawSprite = _sprite
			fillColor = _xml.@fillColor
			fillAlpha = _xml.@fillAlpha
			strokeColor = _xml.@strokeColor
			strokeAlpha = _xml.@strokeAlpha
			stroke = _xml.@stroke
			sMode = _xml.@shape
		}
		
		protected function createXML(_shape:String=""):void
		{
			if (bUseXML)
			{
				xmlShape = XML_drawNode.copy()
				xmlShape.@fillColor = fillColor
				xmlShape.@fillAlpha = fillAlpha
				xmlShape.@strokeColor = strokeColor
				xmlShape.@strokeAlpha = strokeAlpha
				xmlShape.@stroke = stroke
				xmlShape.@blendMode = drawShape.blendMode
				xmlShape.@shape = _shape
			}
			
		}
		
		protected function addPointNode(_x:Number,_y:Number):void
		{
			if (bUseXML)
			{
				xmlNode = XML_drawPoint.copy()
				xmlNode.@x = _x 
				xmlNode.@y = _y
				XmlCtrl.addChild(XMLList(xmlShape),XMLList(xmlNode))
			}
			
		}
			
		protected function addRectNode(_x:Number,_y:Number,_w:Number,_h:Number,_a:Number=30):void
		{
			if (bUseXML)
			{
				xmlNode = XML_drawPoint.copy()
				xmlNode.@x = _x 
				xmlNode.@y = _y
				xmlNode.@width = _w
				xmlNode.@height = _h
				xmlNode.@angle = _a
				XmlCtrl.addChild(XMLList(xmlShape),XMLList(xmlNode))
			}
			
		}
		
		
		public function getShapeXML():XML
		{
			return xmlShape
		}
	}
}