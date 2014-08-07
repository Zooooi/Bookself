package SWFKit {
	
	import flash.external.*;
	
	public dynamic class FileStream extends BaseObj {
		public function FileStream(...args) {
			var ret:*;
			if (args.length == 0) {
				super.fnBaseObjByName("FileStream");
			}
			else if (args.length == 1) {
				ret = ExternalInterface.call("ffish_new", "FileStream", args[0]);
				if (ret == null || ret == undefined) this.Identifier = 0;
				else this.Identifier = ret;
			}
			else {
				ret = ExternalInterface.call("ffish_new", "FileStream", 
					args[0], args[1]);
				if (ret == null || ret == undefined) this.Identifier = 0;
				else this.Identifier = ret;
			}
		}
	}
}