package JsC.sys{
	public class System {
		//--------------------------------------------------------------------------------(实用类）复制对象
		public static function CheckOS(): String {
			import flash.system.Capabilities;
			var _OS: String = String(Capabilities.os).toLocaleLowerCase()
			var _Out: String
			
			if (_OS.indexOf("linux") > -1) {
				_Out = "$Linux"
			} else if (_OS.indexOf("win")>-1) {
				_Out = "$Win"
			} else {
				_Out = "$Mac"
			}
			return _Out
		}
	}
}