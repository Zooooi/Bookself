package SWFKit {
	import flash.external.*;
	
	public dynamic class ActiveXObject extends BaseObj {
		public function ActiveXObject(progID:*) {
			if (progID == null) {
				this.Identifier = 0;
			}
			else {
				var ret:* = ExternalInterface.call("ffish_new", "ActiveXObject", progID);
				if (ret == null || ret == undefined) this.Identifier = 0;
				else this.Identifier = ret;
			}
		}
		
		public static function fromID(id: Number): ActiveXObject {
			var ax:ActiveXObject = new ActiveXObject(null);
			ax.Identifier = id;
		
			return ax;
		}
	}
}