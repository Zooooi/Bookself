package SWFKit.application {

	import SWFKit.BaseObj;

	public dynamic class Appearance extends BaseObj {
		
		public static var WSRECTANGLE:int = 		0;
		public static var WSTRANSPARENT:int = 		1;
		public static var BSNONE:int = 				0x00000001;
		public static var BSSINGLE:int = 			0x00000010;
		public static var BSRESIZABLE:int =			0x00000100;
		public static var BSSMALLCAPTION:int = 		0x00001000;
		public static var BSHIDETASKBUTTON:int = 	0x00010000;
		public static var BIMAXIMIZE:int = 			0x00000001;
		public static var BIMINIMIZE:int = 			0x00000010;
		public static var BISYSTEMMENU:int = 		0x00000100;
		public static var BIHELP:int = 				0x00001000;
		public static var SMSHOWALL:int = 			0x00000001;
		public static var SMNORMAL:int =			0x00000010;
		public static var SMNOBORDER:int =			0x00000002;
		public static var SMSTRETCHFIT:int =		0x00000100;
		
		public function Appearance() {
			super.fnBaseObjByName("_Appearance_");
		}
	}
}