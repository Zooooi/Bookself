package SWFKit {
	
	import flash.external.*;
	
	public dynamic class URLShortcut extends BaseObj {
		public function URLShortcut(fileName:String) {
			var ret:* = ExternalInterface.call("ffish_new", "URLShortcut", fileName);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}