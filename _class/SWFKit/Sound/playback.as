package SWFKit.Sound
{
	import flash.external.*;
	import SWFKit.BaseObj;
	
	public dynamic class playback extends BaseObj {
		public function playback() {
			super.fnBaseObjByName("_SOund_Playback_");
		}
		
		public static function get masterMute():Boolean	{
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"masterMute");
		}
		
		public static function set masterMute(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "masterMute", value);
		}
		
		public static function get masterVolume():* {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"masterVolume");
		}
		
		public static function set masterVolume(value:Array):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "masterVolume", value);
		}
		
		public static function get waveMute():Boolean {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"waveMute");
		}
		
		public static function set waveMute(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "waveMute", value);
		}
		
		public static function get waveVolume():* {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"waveVolume");
		}
		
		public static function set waveVolume(value:Array):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "waveVolume", value);
		}
		
		public static function get midiMute():Boolean {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"midiMute");
		}
		
		public static function set midiMute(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "midiMute", value);
		}
		
		public static function get midiVolume():* {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"midiVolume");
		}
		
		public static function set midiVolume(value:Array):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "midiVolume", value);
		}
		
		public static function get CDMute():Boolean	{
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"CDMute");
		}
		
		public static function set CDMute(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "CDMute", value);
		}
		
		public static function get CDVolume():* {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"CDVolume");
		}
		
		public static function set CDVolume(value:Array):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "CDVolume", value);
		}
		
		public static function get lineInMute():Boolean	{
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"lineInMute");
		}
		
		public static function set lineInMute(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "lineInMute", value);
		}
		
		public static function get lineInVolume():*	{
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"lineInVolume");
		}
		
		public static function set lineInVolume(value:Array):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "lineInVolume", value);
		}
		
		public static function get microphoneMute():Boolean {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"microphoneMute");
		}
		
		public static function set microphoneMute(value:Boolean):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "microphoneMute", value);
		}
		
		public static function get microphoneVolume():int {
			return ExternalInterface.call("ffish_getprop", "_SOund_Playback_", 
				"microphoneVolume");
		}
		
		public static function set microphoneVolume(value:int):void {
			ExternalInterface.call("ffish_setprop", "_SOund_Playback_", 
								   "microphoneVolume", value);
		}
	}
}