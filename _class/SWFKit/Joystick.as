package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Joystick extends BaseObj {
		public function Joystick(guid:String) {
			var ret:* = ExternalInterface.call("ffish_new", "Joystick", guid);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
	}
}