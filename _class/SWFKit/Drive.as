package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Drive extends BaseObj {
		public function Drive(drive:*) {
			if (typeof(drive) == "number") {
				super.fnBaseObjByID(drive);
			}
			else {
				var ret:* = ExternalInterface.call("ffish_new", "Drive", drive);
				if (ret == null || ret == undefined) this.Identifier = 0;
				else this.Identifier = ret;
			}
		}
		
		public static function get drives():Array {
			var drives:Array = ExternalInterface.call("ffish_getprop", "Drive", "drives");				
			var ret:Array = new Array();
			for (var i:int = 0; i < drives.length; i++)	{
				ret.push(new Drive(drives[i]));
			}
			
			return ret;
		}
	}
}