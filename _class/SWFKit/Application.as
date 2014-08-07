package SWFKit {
	import flash.external.*;
	
	public dynamic class Application extends BaseObj {
		public function Application() {
			super.fnBaseObjByName("Application");
		}
		
		public function get traceWnd():Window {
			var window:Number = ExternalInterface.call("ffish_getprop", "Application", 
				"traceWnd");
			return new Window(window);
		}
	}
}