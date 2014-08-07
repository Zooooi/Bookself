package JsC.geom{
	import flash.display.DisplayObject
	import flash.display.MovieClip;
	import flash.geom.Rectangle
			
	public class Transforms {
		//--------------------------------------------------------------------------------顏色
		public static function color(_this:Object, _color:uint):void 
		{
			import flash.display.DisplayObject;
			import flash.geom.ColorTransform;
			import flash.geom.Rectangle;
			var _colorTransform:ColorTransform = new ColorTransform();
			_colorTransform.color=_color;
			_this.transform.colorTransform=_colorTransform;
		}
		
		
		
		//--------------------------------------------------------------------------------對齊
		public static function align(_Array:Array, _parameter1:String = "center", _parameter2:String = "center"):void 
		{
			var mS:*= _Array[0];
			if (_Array.length<=1) {
				return;
			}
			for (var nP:uint = 1; nP < _Array.length; nP++) {
				var mT:*= _Array[nP];
				var nX:Number
				var nY:Number
				if (mS.parent == mT.parent) {
					nX = mS.x
					nY = mS.y
				}else {
					nX = mS.getRect(mT.parent).x
					nY = mS.getRect(mT.parent).y
				}
				switch (_parameter1) {
					case "left" :
						mT.x= nX 
						break;
					case "center" :
						mT.x= nX +((mS.width+mS.getRect(mS).x)-(mT.width+mT.getRect(mT).x))/2-mT.getRect(mT).x/2
						break;
					case "right" :
						mT.x= nX +(mS.width+mS.getRect(mS).x)-(mT.width+mT.getRect(mT).x)
						break;
					default:
						
				}
				switch (_parameter2) {
					case "top" :
						mT.y= nY
						break;
					case "center" :
						mT.y = nY + ((mS.getRect(mS).height+mS.getRect(mS).y)-(mT.height+mT.getRect(mT).y)) / 2-mT.getRect(mT).y/2
						break;
					case "bottom" :
						mT.y= nY +(mS.getRect(mS).height+mS.getRect(mS).y)-(mT.height+mT.getRect(mT).y)
						break;
					default:
				}
			}
		}
		
		
		public static function alignRect(_Array:Array, _Rect:Rectangle, _parameter1:String = "center", _parameter2:String = "center"):void
		{
			
			for (var nP:uint = 0; nP < _Array.length; nP++) 
			{
				var mT:*= _Array[nP];
				switch (_parameter1) 
				{
					case "left" :
						mT.x=_Rect.x;
						break;
					case "center" :
						mT.x=_Rect.x+((_Rect.width+_Rect.x)-(mT.width+mT.getRect(mT).x))/2-mT.getRect(mT).x/2
						break;
					case "right" :
						mT.x=_Rect.x+(_Rect.width+_Rect.x)-(mT.width+mT.getRect(mT).x)
						break;
					default:
							
				}
				switch (_parameter2) 
				{
					case "top" :
						mT.y=_Rect.y;
						break;
					case "center" :
						mT.y = _Rect.y + ((_Rect.height+_Rect.y)-(mT.height+mT.getRect(mT).y)) / 2-mT.getRect(mT).y/2
						break;
					case "bottom" :
						mT.y=_Rect.y+(_Rect.height+_Rect.y)-(mT.height+mT.getRect(mT).y)
						break;
					default:
				}
			}
			
		}
		
		public static function alignRect2(_Array:Array, _Rect:Rectangle, _parameter1:String = "center", _parameter2:String = "center"):void
		{
			
			for (var nP:uint = 0; nP < _Array.length; nP++) 
			{
				var mT:*= _Array[nP];
				switch (_parameter1) 
				{
					case "left" :
						mT.x=_Rect.x;
						break;
					case "center" :
						mT.x=_Rect.x+((_Rect.width+_Rect.x)-(mT.width*mT.scaleX+mT.getRect(mT).x))/2-mT.getRect(mT).x/2
						break;
					case "right" :
						mT.x=_Rect.x+(_Rect.width+_Rect.x)-(mT.width*mT.scaleX+mT.getRect(mT).x)
						break;
					default:
						
				}
				switch (_parameter2) 
				{
					case "top" :
						mT.y=_Rect.y;
						break;
					case "center" :
						mT.y = _Rect.y + ((_Rect.height+_Rect.y)-(mT.height*mT.scaleY+mT.getRect(mT).y)) / 2-mT.getRect(mT).y/2
						break;
					case "bottom" :
						mT.y=_Rect.y+(_Rect.height+_Rect.y)-(mT.height*mT.scaleY+mT.getRect(mT).y)
						break;
					default:
				}
			}
			
		}
		
		public static function scaleRect(_Array:Array, _Rect:Rectangle,_rate:Boolean=true):void
		{
			var nW:int = _Rect.width
			var nH:int = _Rect.height
			var nC:Number
			
			for (var nP:uint = 0; nP < _Array.length; nP++) 
			{
				var mT:*= _Array[nP];
				
				if (mT.width/mT.height>nW/nH) 
				{
					nC = nW / mT.width
					mT.width = nW
					mT.height *= nC
				}else {
					nC = nH / mT.height
					mT.height = nH
					mT.width *= nC
				}
				
			}
		}
		
		public static function scaleRect2(_Array:Array, _Rect:Rectangle,_rate:Boolean=true):void
		{
			var nW:int = _Rect.width
			var nH:int = _Rect.height
			var nC:Number
			
			for (var nP:uint = 0; nP < _Array.length; nP++) 
			{
				var mT:*= _Array[nP];
				
				if (mT.width/mT.height>nW/nH) 
				{
					nC = nW / mT.width
					mT.scaleX = nC
					mT.scaleY = nC
				}else {
					nC = nH / mT.height
					mT.scaleX = nC
					mT.scaleY = nC
				}
				
			}
		}
		
	
	}
}