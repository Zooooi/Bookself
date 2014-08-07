package SWFKit.application {

	import SWFKit.BaseObj;

	public dynamic class Behaviour extends BaseObj {
		
		public static var CMCONFIGURE:int =	0x00000001;
		public static var CMFLASHPLAY:int =	0x00000010;
		public static var CMABOUT:int =		0x00000100;
		public static var CMHELP:int =		0x00001000;
		
		public function Behaviour() {
			super.fnBaseObjByName("_Behaviour_");
		}
	}
}