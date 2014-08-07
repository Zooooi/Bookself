package SWFKit {
	
	import flash.external.*;
	
	public dynamic class File extends BaseObj {
		public function File(fileName:String) {
			var ret:* = ExternalInterface.call("ffish_new", "File", fileName);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}