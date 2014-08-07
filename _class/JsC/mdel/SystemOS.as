package JsC.mdel
{
	import flash.system.Capabilities;

	public class SystemOS
	{
		public static const PC:String = "PC"
		public static const MOBILE:String = "MOBILE"	
		public static var mode:String
		
		private static var bIOS:Boolean
		private static var bAND:Boolean
		public function SystemOs():void
		{
			
		}
		
		private static function getOS():String
		{
			return Capabilities.os
		}
		
		public static function isAndroid():Boolean
		{
			return  Capabilities.os.indexOf("Linux")>=0
		}
		public static function isIOS():Boolean
		{
			return  Capabilities.os.indexOf("iPhone")>=0
		}
		
		public static function get isMobile():Boolean
		{
			return  mode == MOBILE
		}
		
		public static function get isPc():Boolean
		{
			return mode == PC
		}
		
		
		public static function init():void
		{
			if (Capabilities.cpuArchitecture == "ARM")
			{
				if (Capabilities.os.indexOf("Linux")>=0)
				{
					bAND = true
					mode = MOBILE
				}else if (Capabilities.os.indexOf("iPhone")>=0){
					bIOS = true
					mode = MOBILE
				}
			}else{
				mode = PC
			}
			
		}
	}
}