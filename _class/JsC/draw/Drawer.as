package JsC.draw
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import JsC.events.JEvent;

	public class Drawer extends Drawer_base_dr
	{
		
		protected var drawClass:Drawer_drawBase
		
		public function Drawer()
		{
			
		}
		
		public function createShape(_mode:String):void
		{
			sMode = _mode
			createObject()
			drawClass.fillColor = fillColor
			drawClass.fillAlpha = fillAlpha
			drawClass.strokeColor = strokeColor
			drawClass.strokeAlpha = strokeAlpha
			drawClass.stroke = stroke
			drawClass.setDrawTargets(drawSprite,drawHitTest,bUseXML)
			drawClass.setDrawRect(nX,nY,nW,nH)
			drawClass.addEventListener(JEvent.END,onJEvent)
		}
		
		protected function createObject():void
		{
			switch(sMode)
			{
				default:
				case Drawer_type.drawingFree:
					drawClass = new Drawer_drawFree;break;
				
				case Drawer_type.drawLine:
				case Drawer_type.drawNite:
					drawClass = new Drawer_drawLine;break
				
				case Drawer_type.drawZebraStripes:
					drawClass = new Drawer_drawZebraStripes;break;
				
				case Drawer_type.drawingRect:
					drawClass = new Drawer_drawRect;break;
				
				case Drawer_type.drawCircle:
					drawClass = new Drawer_drawCircle;break;
				
				case Drawer_type.drawCircle:
					drawClass = new Drawer_drawCircle;break;
				
				case Drawer_type.drawDelta:
					drawClass = new Drawer_drawDelta;break;
				
				case Drawer_type.drawArrow:
				case Drawer_type.drawArrow2:
					drawClass = new Drawer_drawArrow;break;
			}
			drawClass.setMode(sMode)
		}
		
		
		override public function drawFromMouse(_hitLayer:Sprite=null):void
		{
			super.drawFromMouse(_hitLayer)
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onStageMouseEvent)
			stage.addEventListener(MouseEvent.MOUSE_UP,onStageMouseEvent)
			drawClass.drawStart()
		}
		
		override public function drawFromXML(_sprite:Sprite,_xml:XML):void
		{
			super.drawFromXML(_sprite,_xml)
			createObject()
			drawClass.drawFromXML(_sprite,_xml)
		}
		
		protected function onStageMouseEvent(event:MouseEvent):void
		{
			switch(event.type)
			{
				case MouseEvent.MOUSE_MOVE:
					drawClass.drawingWithMouse()
					break;
				case MouseEvent.MOUSE_UP:
					stage.removeEventListener(MouseEvent.MOUSE_MOVE,arguments.callee)
					stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee)
					drawClass.drawEnd()
					break;	
			}
		}
		
		override public function getShapeXML():XML
		{
			return drawClass.getShapeXML()
		}
		
		
		protected function onJEvent(event:Event):void
		{
			dispatchEvent(new JEvent(event.type))
		}			
		
		
	}
}

