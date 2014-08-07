package jsProject.ctrl
{
	import JsC.events.JEvent;
	import JsC.sprite.Drawer;
	import JsC.sprite.Drawer_earse;
	import JsC.sprite.Drawer_move;
	import JsC.sprite.Drawer_type;
	
	import components.books.BookPage;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import jsProject.mdel.DrawData;
	import jsProject.mdel.Viewers;
	import jsProject.view.PageDrawLayer;

	public class DrawCtrl extends DrawData
	{
		private var stage:Stage
		private var drawer:Drawer
		private var drawSprite:Sprite
		private var bookpage:BookPage
		private var pageDrawLayer:PageDrawLayer
		
		public function DrawCtrl():void
		{
			init()
		}
	
		
		public function remove():void
		{
			Viewers.getPage().$pageOnDraw(false)
			bookpage.$getHitTest().removeEventListener(MouseEvent.MOUSE_DOWN,onStageMouseEvent)
			bookpage.$getHitTest().mouseEnabled = false
		}
		
		private function init():void
		{
			bookpage = Viewers.getPage()
			stage = bookpage.stage
			Viewers.getPage().$pageOnDraw(true)
			bookpage.$getHitTest().mouseEnabled = true
			bookpage.$getHitTest().addEventListener(MouseEvent.MOUSE_DOWN,onStageMouseEvent)
				
			switch(mode)
			{
				case modeEarseAll:
					var i:uint
					for (i = 0; i < bookpage.$getCurrentDisplayPage().length; i++) 
					{
						pageDrawLayer = PageDrawLayer(bookpage.$getCurrentDisplayPage()[i].$getDrawLayer().$delAll())
					}
					break;
			}
		}
		
		protected function onStageMouseEvent(event:MouseEvent):void
		{
			pageDrawLayer = null
			var i:int
			for (i = 0; i < bookpage.$getCurrentDisplayPage().length; i++) 
			{
				if (bookpage.$getCurrentDisplayPage()[i].hitTestPoint(stage.mouseX,stage.mouseY))
				{
					pageDrawLayer = PageDrawLayer(bookpage.$getCurrentDisplayPage()[i].$getDrawLayer())
					break
				}
			}
			//......................................................................................................init
			if (pageDrawLayer)
			{
				drawSprite = Sprite(pageDrawLayer.getChildByName("draw"))
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
				
			}
		}
		
		protected function onDrawEnd(event:JEvent):void
		{
			pageDrawLayer.$addXML(drawer.getShapeXML())
		}
		
		protected function onMoveEnd(event:JEvent):void
		{
			pageDrawLayer.$setLoc(event._id,event._x,event._y)
		}
			
		protected function onEarseEvent(event:JEvent):void
		{
			switch(event.type)
			{
				case JEvent.REMOVE:
					pageDrawLayer.$delNode(event._id)
					break;
					
				case JEvent.END:
					pageDrawLayer.$saveNode()
					break;
			}
			
		}	
		
	}
}