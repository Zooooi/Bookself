package SWFKit {
	import flash.external.*;
	
	public dynamic class Shell extends BaseObj {
		public function Shell() {
			super.fnBaseObjByName("Shell");
		}
		
		public function run(...arguments):* {
			var window:* = ExternalInterface.call("ffish_call2", 
				"Shell", "run", arguments);
			if (window == null) return null;
			return new Window(window);
		}
	}
}