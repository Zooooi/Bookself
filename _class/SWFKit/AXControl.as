package SWFKit {
	import flash.external.*;
	
	public dynamic class AXControl extends BaseObj {
		public function AXControl(id: Number) {
			super.fnBaseObjByID(id);
		}
	
		public function get window():Window {
			var window:Number = ExternalInterface.call("ffish_getprop", this.Identifier,
												"window");
			return new Window(window);
		}
	
		public function get activex():ActiveXObject {
			var ax:Number = ExternalInterface.call("ffish_getprop", this.Identifier, 
				"activex");
			return ActiveXObject.fromID(ax);
		}
	}
}