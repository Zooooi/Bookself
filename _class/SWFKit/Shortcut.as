package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Shortcut extends BaseObj {
		public function Shortcut(fileName:String) {
			var ret:* = ExternalInterface.call("ffish_new", "Shortcut", fileName);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}