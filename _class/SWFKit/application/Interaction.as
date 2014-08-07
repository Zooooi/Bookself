package SWFKit.application {

	import SWFKit.BaseObj;

	public dynamic class Interaction extends BaseObj {
		
		public static var LBSEND:int =				0;
		public static var LBDRAG:int =				1;
		public static var LBIGNORE:int =			2;
		public static var RBSEND:int =				3;
		public static var RBCONTEXTMENU:int =		1;
		public static var RBIGNORE:int =			2;
		public static var KPSEND:int =				0x001;
		public static var KPIGNORE:int =			0x010;
		public static var KPDISABLEWINDOWKEYS:int =	0x100;
		public static var EKESC:int =				0x001;
		public static var EKHOTKEY:int =			0x010;
		
		public function Interaction() {
			super.fnBaseObjByName("_Interaction_");
		}
	}
}