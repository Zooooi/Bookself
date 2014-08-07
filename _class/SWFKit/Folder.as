package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Folder extends BaseObj {
		public function Folder(folderName:String) {
			var ret:* = ExternalInterface.call("ffish_new", "Folder", folderName);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
		
		public function files(...args):Array {
			if (args.length == 0) {
				return ExternalInterface.call("ffish_getprop", this.Identifier, 
											  "files");
			}
			else {
				return ExternalInterface.call("ffish_call", this.Identifier, 
											  "files", args[0]);
			}
		}	
	}
}