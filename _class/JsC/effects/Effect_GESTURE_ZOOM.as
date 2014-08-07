package JsC.effects
{
	import JsC.events.JEffectEvent;
	
	import flash.display.Sprite;
	import flash.events.TransformGestureEvent;
	import flash.geom.Rectangle;
	
	public class Effect_GESTURE_ZOOM extends EffectZoom
	{
		
		private var nScale:Number
		private var bAct:Boolean
		public function Effect_GESTURE_ZOOM(_content:Sprite, _mask:Rectangle=null, _timeStep:uint=10)
		{
			super(_content, _mask, _timeStep);
			sMode = modebyMask
			_content.addEventListener(TransformGestureEvent.GESTURE_ZOOM,onPageZoomTransforGestureEvent)
			bAct = true
		}
		
		protected function onPageZoomTransforGestureEvent(event:TransformGestureEvent):void
		{
			if (!bAct) return
			var _me:Sprite = Sprite(event.currentTarget)
			var _scale:Number = (event.scaleX + event.scaleY)/2
			nX = _me.scaleX * _scale
			nY = _me.scaleY * _scale
			if (nX < nMinScaleX)
			{
				nX = nMinScaleX
			}else if (nX>nMaxScaleX){
				nX = nMaxScaleX
			}
			if (nY < nMinScaleY)
			{
				nY = nMinScaleY
			}else if (nY>nMaxScaleY){
				nY = nMaxScaleY
			}
			ZoomAction()
			if (nX == nMinScaleX && nY == nMinScaleY)dispatchEvent(new JEffectEvent(JEffectEvent.MIN))
			if (nX == nMaxScaleX && nY == nMaxScaleY)dispatchEvent(new JEffectEvent(JEffectEvent.MAX))
		}
		
		public function setEnable(_b:Boolean):void
		{
			bAct = _b
		}
		
		public function getEnable():Boolean
		{
			return bAct
		}
		
	}
}