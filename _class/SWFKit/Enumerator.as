package SWFKit {
	import flash.external.*;
	
	public dynamic class Enumerator extends BaseObj {
		public function Enumerator(collection:Object) {
			var ret:* = ExternalInterface.call("ffish_new", "Enumerator", 
				collection);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}