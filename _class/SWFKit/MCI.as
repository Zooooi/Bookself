package SWFKit {
	import flash.external.*;
	
	public dynamic class MCI extends BaseObj {
		public function MCI() {
			super.fnBaseObjByName("MCI");
		}
		
		public function get playerWindow():Window {
			var window:Number = ExternalInterface.call("ffish_getprop", 
				this.Identifier, "playerWindow");
			return new Window(window);
		}
	}
}