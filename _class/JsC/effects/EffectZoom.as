package JsC.effects 
{
	import JsC.events.JEffectEvent;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EffectZoom extends EffectBase
	{
		
		protected const modebyMask:String = "modebyMask"
		protected const modebyPoint:String = "modebyPoint"
		protected const modebyRect:String = "modebyRect"
		protected var sMode:String
		
		protected var nRegPoint:Point
		protected var nX:Number
		protected var nY:Number
		protected var nScaleX:Number = 0.5
		protected var nScaleY:Number = 0.5
		protected var nMinScaleX:Number = 0.5
		protected var nMinScaleY:Number = 0.5
		protected var nMaxScaleX:Number = 2
		protected var nMaxScaleY:Number = 2
		protected var nStepX:Number = 0.05
		protected var nStepY:Number = 0.05
		protected var nCenterX:Number
		protected var nCenterY:Number
		
		
		public function EffectZoom(_content:Sprite,_mask:Rectangle=null,_timeStep:uint=10) 
		{
			super(_content,_mask,_timeStep)
			nX = _content.scaleX
			nY = _content.scaleY
			if (_mask!=null) 
			{
				sMode = modebyMask
				nCenterX = mask.width / 2
				nCenterY = mask.height / 2
			}
		}
		
		public function ZoomByMask():void
		{
			sMode = modebyMask
		}
		public function ZoomByPoint(_point:Point):void
		{
			nRegPoint = _point
			sMode = modebyPoint
		}
		
		public function setMaxScale(_x:Number, _y:Number):void
		{
			nMaxScaleX = _x
			nMaxScaleY = _y
		}
		
		public function setMinScale(_x:Number, _y:Number):void
		{
			nMinScaleX = _x
			nMinScaleY = _y
		}
		public function setCurrentScale(_x:Number, _y:Number):void
		{
			nScaleX = _x
			nScaleX = _y
		}
		
		public function setZoomStep(_x:Number, _y:Number):void
		{
			nStepX = _x
			nStepY = _y
		}
		
		
		public function ZoomIn():void
		{
			nX += nStepX
			nY += nStepY
			if (nX > nMaxScaleX) nX = nMaxScaleX
			if (nY > nMaxScaleY) nY = nMaxScaleY
			ZoomAction(true)
		}
		
		public function reset():void
		{
			nX = nMinScaleX
			nY = nMinScaleY
		}
		
		
		public function ZoomOut():void
		{
			nX -= nStepX
			nY -= nStepY
			if (nX < nMinScaleX) nX = nMinScaleX
			if (nY < nMinScaleY) nY = nMinScaleY
			ZoomAction(false)
		}
		
		
		protected function ZoomAction(_b:Boolean=true):void
		{
			var _reg:Point 
			switch (sMode) 
			{
				case modebyMask:
					if (mask!=null) _reg = content.globalToLocal(new Point(mask.x + mask.width / 2, mask.y + mask.height / 2))
					break;
				case modebyRect:
					_reg = content.globalToLocal(new Point(nL + nW / 2, nT + nH / 2))
					break;
				case modebyPoint:
					_reg = content.globalToLocal(nRegPoint)
					break
			}
			var A:Point = content.parent.globalToLocal(content.localToGlobal(_reg))  
			content.scaleX =  nX
			content.scaleY =  nY
			var B:Point = content.parent.globalToLocal(content.localToGlobal(_reg))
			content.x += A.x - B.x 
			content.y += A.y - B.y	
			if (_b) 
			{
				super.dispatch(JEffectEvent.Drag_Stop)
			}else {
				super.dispatch(JEffectEvent.Drag_Refresh)
			}
			dispatchEvent(new JEffectEvent(JEffectEvent.UPADTE))
		}
		
	}
	
}