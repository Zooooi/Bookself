package JsC.effects
{
	import JsC.events.JEffectEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author ...
	 */
	
	public class EffectDrag extends EffectBase
	{
		private var nOffsetX:Number = 20
		private var nOffsetY:Number = 20
		
		private var nMouseX:Number
		private var nMouseX2:Number
		private var nMouseY:Number
		private var nMouseY2:Number
		private var nEndX:Number
		private var nEndY:Number
		private var bDW:Boolean
		private var bResizeWithMask:Boolean
		private var bResizeWithRect:Boolean
		private var bAutoMove:Boolean
		private var nTimer:Timer
		
		
		private var nInitSpeed:Number
		
		public function EffectDrag(_content:Sprite,_mask:Rectangle=null,_timeStep:uint=10) 
		{
			super(_content, _mask,_timeStep)
			setMdel()
			setCtrl()
		}
		
		private function setMdel():void
		{
			nTimer = new Timer(nStep)
			nInitSpeed = nF
			bDW = false
			bAutoMove = false
			if (mask != null) setRectAction(mask.x, mask.y, getWidth() - mask.width, getHeight() - mask.height)
		}
		
		private function setCtrl():void
		{
			nTimer.addEventListener(TimerEvent.TIMER,onMoving)
			content.addEventListener(JEffectEvent.Drag_Stop,stop)
			content.addEventListener(JEffectEvent.Drag_Start,start)
			content.addEventListener(JEffectEvent.Drag_Resume, resume)
			content.addEventListener(JEffectEvent.Drag_Refresh, refresh)
		}
		
		protected function onEvent(event:Event):void
		{
		
			if (content.stage.hasEventListener(MouseEvent.MOUSE_UP))
			{
				content.stage.removeEventListener(MouseEvent.MOUSE_UP,stage_MouseUP)
			}
		}
		
		protected function onMoving(event:TimerEvent):void
		{
			runing()
		}
		
		public function set dynamicMask(_b:Boolean):void
		{
			bResizeWithMask = _b
		}
		
		public function set dynamicRect(_b:Boolean):void
		{
			bResizeWithRect = _b
		}
		
		public function setSpeed(_value:Number):void
		{
			nF = _value
		}
		
		public function setOffset(_valueX:Number=0,_valueY:Number=0):void
		{
			nOffsetX = mask.x + _valueX
			nOffsetY = mask.y + _valueY
		}
		
		public function resetSpeed():void
		{
			nF = nInitSpeed
		}
		
		public function set autoMove(_b:Boolean):void
		{
			bAutoMove = _b
		}
		
		private function contentMouseEvent(evt:MouseEvent=null):void
		{
			bDW = true
			switch (true) 
			{
				case bAutoMove:
					nMouseX = nL + nW /2
					nMouseY = nT + nH /2
					break;
				case bDW:
					nTimer.start()
					nMouseX = content.stage.mouseX
					nMouseY = content.stage.mouseY
					nMouseX2 = content.stage.mouseX
					nMouseY2 = content.stage.mouseY
					break;
			}
			content.stage.addEventListener(MouseEvent.MOUSE_UP, stage_MouseUP)
			content.stage.addEventListener(Event.REMOVED_FROM_STAGE,onEvent)
		}
		
		
		private function runing():void
		{
			if (bAutoMove) 
			{
				nEndX = content.x - (content.stage.mouseX - nMouseX)
				nEndY = content.y - (content.stage.mouseY - nMouseY)
			}else if (bDW) {
				content.startDrag()
				nEndX = content.x + (content.stage.mouseX - nMouseX2)* 0.4
				nEndY = content.y + (content.stage.mouseY - nMouseY2)* 0.4
				
				nMouseX2 = content.stage.mouseX
				nMouseY2 = content.stage.mouseY
				if (Math.abs(content.stage.mouseX - nMouseX)<100)
				{
					nMouseX = content.stage.mouseX
				}
				if (Math.abs(content.stage.mouseY - nMouseY)<100)
				{
					nMouseY = content.stage.mouseY
				}
			}else {
				content.x +=  (nEndX - content.x) * nF
				content.y +=  (nEndY - content.y) * nF
			}
			refresh()
		}
		
		private function stage_MouseUP(evt:MouseEvent):void
		{
			switch(evt.type)
			{
				case MouseEvent.MOUSE_UP:
					switch (true) 
					{
						case bDW:
							nEndX = content.x + (content.stage.mouseX - nMouseX)
							nEndY = content.y + (content.stage.mouseY - nMouseY)
							break;
					}
					bDW = false
					content.stopDrag()
					content.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_MouseUP)
					content.stage.removeEventListener(Event.REMOVED_FROM_STAGE,onEvent)
					nTimer.start()
					break;
				
			}
		
		}
		
		public function refresh(evt:Event=null):void
		{
			
			if (bResizeWithMask) setRectAction(mask.x, mask.y, getWidth() - mask.width, getHeight() - mask.height)
			var nTemp:Number
			if (content.width>mask.width)
			{
				if (content.x > nL || (getWidth() < nW && content.x < nL))
				{
					nEndX = nL
					if (content.x > nEndX + nOffsetX) content.x = nEndX + nOffsetX
				}else if (content.x < nL - nW)
				{
					nEndX = nL - nW
					if (content.x < nEndX - nOffsetX) content.x = nEndX - nOffsetX
				}
			}else{
				nEndX = nL + (mask.width - content.width)/2
			}
			
			if (content.height>mask.height)
			{
				if (content.y > nT || (getHeight() < nH && content.y < nT)) 
				{
					nEndY = nT
					if (content.y > nEndY + nOffsetY) content.y = nEndY + nOffsetY
				}else if (content.y < nT - nH)
				{
					nEndY = nT - nH
					if (content.y < nEndY - nOffsetY) content.y = nEndY - nOffsetY
				}
			}else{
				nEndY = nT + (mask.height - content.height)/2
			}
			if (Math.abs(nEndX - content.x)<=0.3 && Math.abs(nEndY - content.y)<=0.3 && bDW==false) nTimer.stop()
		}
		
		public function start(evt:Event=null):void
		{
			add()
			contentMouseEvent()
		}
		
		public function stop(evt:Event=null):void
		{
			nEndX = content.x
			nEndY = content.y
			bDW = false
			nTimer.stop()
		}
		
		public function remove(evt:Event=null):void
		{
			content.removeEventListener(MouseEvent.MOUSE_DOWN, contentMouseEvent)
			if (content.stage)content.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_MouseUP)
			nTimer.stop()
			nTimer.removeEventListener(TimerEvent.TIMER,onMoving)
			content.removeEventListener(JEffectEvent.Drag_Stop,stop)
			content.removeEventListener(JEffectEvent.Drag_Start,start)
			content.removeEventListener(JEffectEvent.Drag_Resume, resume)
			content.removeEventListener(JEffectEvent.Drag_Refresh, refresh)
		}
		
		public function add(evt:Event=null):void
		{
			content.addEventListener(MouseEvent.MOUSE_DOWN, contentMouseEvent)
			nTimer.addEventListener(TimerEvent.TIMER,onMoving)
			content.addEventListener(JEffectEvent.Drag_Stop,stop)
			content.addEventListener(JEffectEvent.Drag_Start,start)
			content.addEventListener(JEffectEvent.Drag_Resume, resume)
			content.addEventListener(JEffectEvent.Drag_Refresh, refresh)
		}
		
		public function resume(evt:Event=null):void
		{
			nEndX = content.x
			nEndY = content.y
			start()
		}
		
		public function run():void
		{
			add()
			nTimer.start()
		}
		
		private function getWidth():Number
		{
			return content.width // * content.scaleX
		}
		
		private function getHeight():Number
		{
			return content.height// * content.scaleY
		}
	}

}