package SWFKit.application {

	import SWFKit.BaseObj;

	public dynamic class SizeAndPos extends BaseObj {
		
		public static var SSDEFAULT:int =		0;
		public static var SSFULLSCREEN:int =	1;
		public static var SSMAXIMIZED:int =		2;
		public static var SSCUSTOMIZED:int =	3;
		public static var SSPERCENT:int = 		4;
	
		public static var ASTOPLEFT:int =		0;
		public static var ASTOPCENTER:int =		1;
		public static var ASTOPRIGHT:int =		2;
		public static var ASCENTERLEFT:int =	3;
		public static var ASSCREENCENTER:int =	4;
		public static var ASCENTERRIGHT:int =	5;
		public static var ASBOTTOMLEFT:int =	6;
		public static var ASBOTTOMCENTER:int =	7;
		public static var ASBOTTOMRIGHT:int =	8;
		
		public function SizeAndPos() {
			super.fnBaseObjByName("_SizeAndPos_");
		}
	}
}