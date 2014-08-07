package JsC.string
{
	
	/**
	 * ...
	 * @author Jason
	 */
	public class Escape 
	{
		public static function clearBothSidesSpace(_S:String):String
		{
			var pattern:RegExp;
			pattern=/(^\s*)|(\s*$)/g;
			_S=_S.replace(pattern,"");
			return _S;
		}
		
		public static function clearHtml(_str:String):String
		{
			return _str.replace(/<([^>]*)>/g,"")
		}
		
		
		public static function isURL(_str:String):Boolean
		{
			var _b:Boolean
			var reg:RegExp = /^[a-zA-z]+:|(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$/
			if (_str.match(reg)!=null)
			{
				_b = true
			}
			return _b
		}
	}
	
}