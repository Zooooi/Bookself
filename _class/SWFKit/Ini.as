package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Ini extends BaseObj {
		public function Ini(fileName:String) {
			var ret:* = ExternalInterface.call("ffish_new", "Ini", fileName);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}