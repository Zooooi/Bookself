package SWFKit {
	
	import flash.external.*;
	
	public dynamic class StringStream extends BaseObj {
		public function StringStream(...args) {
			if (args.length == 0) super.fnBaseObjByName("StringStream");
			else {
				var ret:* = ExternalInterface.call("ffish_new", "StringStream", args[0]);
				if (ret == null || ret == undefined) this.Identifier = 0;
				else this.Identifier = ret;
			}
		}
		
		public function compress():StringStream {
			var id:Number = ExternalInterface.call("ffish_call", this.Identifier, 
				"compress");			
			var ss:StringStream = new StringStream();
			ss.Release();
			ss.Identifier = id;			
			return ss;
		}
		
		public function uncompress():StringStream {
			var id:Number = ExternalInterface.call("ffish_call", this.Identifier, 
				"uncompress");			
			var ss:StringStream = new StringStream();
			ss.Release();
			ss.Identifier = id;			
			return ss;
		}
		
		public static function readFromFile(fileName:String):StringStream {
			var id:Number = ExternalInterface.call("ffish_call", "StringStream", 
				"readFromFile", fileName);			
			var ss:StringStream = new StringStream();
			ss.Release();
			ss.Identifier = id;			
			return ss;
		}
	}
}