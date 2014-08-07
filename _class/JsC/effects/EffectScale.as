package JsC.effects
{
	import JsC.events.JEffectEvent;
	
	import caurina.TransData;
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	public class EffectScale extends EffectZoom
	{
		private var tranData:TransData
		private var nDuration:Number
		private var transition:String
		private var tweenObj:Object
		
		public function EffectScale(_content:Sprite,_mask:Rectangle=null,_timeStep:uint=10) 
		{
			super(_content,_mask,_timeStep)
			tranData = new TransData
			nDuration = 1
			transition = TransData.easenone
		}
		
		public function setTimeDuration(_value:Number):void
		{
			nDuration = _value
		}
		
		public function setTransition(_value:String):void
		{
			transition = _value
		}
		
		public function scaleAction(_scaleX:Number,_scaleY:Number):void
		{
			runTween(_scaleX * nMinScaleX,_scaleY * nMinScaleY)
			
		}
		
		public function scaleIn():void
		{
			
			runTween(nMaxScaleX,nMaxScaleY)
		}
		
		
		public function scaleOut():void
		{
			runTween(nMinScaleX,nMinScaleY)
		}
		
		public function stop():void
		{
			//Tweener.removeTweens(tranData)
		}
		
		
		private function onUpdate():void
		{
			nX = tranData.scaleX
			nY = tranData.scaleY
			ZoomAction()
		}
		
		private function onComplete():void
		{
			dispatchEvent(new JEffectEvent(JEffectEvent.COMPLETE))
		}
		
		private function stopOtherEffect():void
		{
			super.dispatch(JEffectEvent.Drag_Stop)
		}
		
		private function runTween(_scaleX:Number,_scaleY:Number):void
		{
			stopOtherEffect()
			tweenObj = {scaleX:_scaleX, scaleY:_scaleY, time:nDuration, transition:transition,onUpdate:onUpdate,onComplete:onComplete}
			stop()
			tranData.scaleX = content.scaleX
			tranData.scaleY = content.scaleY
			Tweener.addTween(tranData, tweenObj);
			
		}
		
		
		public function setZoom(_x:Number,_y:Number):void
		{
			runTween(_x,_y)
		}
			
	}
}