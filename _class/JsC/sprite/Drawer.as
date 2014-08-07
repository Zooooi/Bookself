package JsC.sprite
{
	import JsC.events.JEvent;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

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

/*drawSprite = Sprite(pageDrawLayer.getChildByName("draw"))
switch(mode)
{
	case modePen:
	case modeNite:
		drawer = new Drawer
		drawer.setDrawTargets(drawSprite,pageDrawLayer.$getHitArea(),true)
		drawer.setDrawRect(0,0,pageDrawLayer.$getWidth(),pageDrawLayer.$getHeight())
		drawer.stroke = currentStroke
		drawer.strokeColor = currentStrokeColor
		drawer.strokeAlpha = currentStrokeAlpha
		drawer.fillColor = currentFillColor
		drawer.fillAlpha = currentFillAlpha
		drawer.addEventListener(JEvent.END,onDrawEnd)
		
		switch(mode)
		{
			case modePen:
				switch(nShapeKind)
				{
					default:
					case 0:drawer.createShape(Drawer_type.drawingFree);break
					case 1:drawer.createShape(Drawer_type.drawLine);break
					case 2:drawer.createShape(Drawer_type.drawZebraStripes);break
					case 3:drawer.createShape(Drawer_type.drawingRect);break
					case 4:drawer.createShape(Drawer_type.drawCircle);break
					case 5:drawer.createShape(Drawer_type.drawDelta);break
					case 6:drawer.createShape(Drawer_type.drawArrow);break
					case 7:drawer.createShape(Drawer_type.drawArrow2);break
				}
				drawer.drawFromMouse()
				break;
			case modeNite:
				drawer.createShape(Drawer_type.drawNite)
				drawer.drawFromMouse()
				break;
		}
		
		break;
	case modeEarse:
		var _earse:Drawer_earse = new Drawer_earse
		_earse.addEventListener(JEvent.REMOVE,onEarseEvent)
		_earse.addEventListener(JEvent.END,onEarseEvent)
		_earse.setTarget(drawSprite)
		_earse.catchAndEarse()
		break
	case modeMove:
		var _move:Drawer_move = new Drawer_move
		_move.addEventListener(JEvent.END,onMoveEnd)
		_move.setMoveRect(0,0,pageDrawLayer.$getWidth(),pageDrawLayer.$getHeight())
		_move.setTarget(drawSprite)
		_move.catchAndMove()
		break
	default:
		break;
}
*/