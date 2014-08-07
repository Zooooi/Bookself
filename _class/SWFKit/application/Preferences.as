package SWFKit.application {

	import SWFKit.BaseObj;

	public dynamic class Preferences extends BaseObj {
		
		public static var WULEFTBUTTON:int =	0x01;
		public static var WURIGHTBUTTON:int =	0x02;
		public static var WUMOUSEMOVE:int =		0x04;
		public static var WUKEYSTROKE:int =		0x08;
		public static var WUESC:int =			0x10;
		public static var WUHOTKEY:int =		0x20;
		
		public function Preferences() {
			super.fnBaseObjByName("_Preferences_");
		}
	}
}