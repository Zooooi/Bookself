package SWFKit.Sound
{
	import flash.external.*;
	import SWFKit.BaseObj;

	public dynamic class recording extends BaseObj {
		public function recording()	{
			super.fnBaseObjByName("_SOund_Recording_");
		}	
		
		public static function get lineInSelect():Boolean {
			return ExternalInterface.call("ffish_getprop", "_SOund_Recording_", 
				"lineInSelect");
		}
		
		public static function set lineInSelect(value:Boolean):void	{
			ExternalInterface.call("ffish_setprop", "_SOund_Recording_", 
								   "lineInSelect", value);
		}
		
		public static function get lineInVolume():*	{
			return ExternalInterface.call("ffish_getprop", "_SOund_Recording_", 
				"lineInVolume");
		}
		
		public static function set lineInVolume(value:Array):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Recording_", 
								   "lineInVolume", value);
		}
		
		public static function get microphoneSelect():Boolean {
			return ExternalInterface.call("ffish_getprop", "_SOund_Recording_", 
				"microphoneSelect");
		}
		
		public static function set microphoneSelect(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Recording_", 
								   "microphoneSelect", value);
		}
		
		public static function get microphoneVolume():int {
			return ExternalInterface.call("ffish_getprop", "_SOund_Recording_", 
				"microphoneVolume");
		}
		
		public static function set microphoneVolume(value:int):void	{
			ExternalInterface.call("ffish_setprop", "_SOund_Recording_", 
								   "microphoneVolume", value);
		}	
	}
}