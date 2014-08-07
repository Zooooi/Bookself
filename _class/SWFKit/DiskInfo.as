package SWFKit {
	import flash.external.*;
	
	public dynamic class DiskInfo extends BaseObj {
		public function DiskInfo(i:int) {
			var ret:* = ExternalInterface.call("ffish_new", "DiskInfo", i);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}