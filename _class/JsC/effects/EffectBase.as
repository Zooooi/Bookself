package JsC.effects 
{
	import JsC.events.JEffectEvent;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	[Event(name = "Drag_Stop", type = "JsC.events.JEffectEvent")]
	[Event(name = "END", type = "JsC.events.JEffectEvent")]
	[Event(name = "STOP", type = "JsC.events.JEffectEvent")]
	[Event(name = "UPADTE", type = "JsC.events.JEffectEvent")]
	[Event(name = "COMPLETE", type = "JsC.events.JEffectEvent")]
	[Event(name = "MIN", type = "JsC.events.JEffectEvent")]
	[Event(name = "MAX", type = "JsC.events.JEffectEvent")]
	
	public class EffectBase extends EventDispatcher
	{
		protected var nF:Number = 0.2
		protected var content:Sprite
		protected var mask:Rectangle
		
		protected var nL:Number 
		protected var nT:Number 
		protected var nH:Number
		protected var nW:Number
		
		protected var nStep:uint
		
		
		
		public function EffectBase(_content:Sprite,_mask:Rectangle=null,_timeStep:uint=10) 
		{
			content = _content
			mask = _mask
			nStep = _timeStep
		}
		
		public function setRect(_rect:Rectangle):void
		{
			mask = _rect
		}
		
		
		protected function setRectAction(_l:Number, _t:Number, _w:Number, _h:Number):void
		{
			nL = _l
			nT = _t
			nW = _w
			nH = _h
			if (nW < 0) nW = 0
			if (nH < 0) nH = 0
		}
		
		
		public function setFriction(_n:Number):void
		{
			nF = _n
		}
		
		
		public function dispatch(_event:String):void
		{
			content.dispatchEvent(new JEffectEvent(_event))
		}
		
		
	}

}