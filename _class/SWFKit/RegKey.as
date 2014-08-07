package SWFKit {
	import flash.external.*;
	
	public dynamic class RegKey extends BaseObj {
		public function RegKey(...args) {
			if (args.length == 0) {
				this.Identifier = 0;
			}
			else {
				var ret:* = ExternalInterface.call("ffish_new", "RegKey", args[0]);
				if (ret == null || ret == undefined) this.Identifier = 0;
				else this.Identifier = ret;
			}
		}
		
		public static function fromID(id: Number):RegKey {
			var rk:RegKey = new RegKey;
			rk.Identifier = id;
		
			return rk;
		}
		
		public function create(...arguments):RegKey	{
			var id:Number = ExternalInterface.call("ffish_call2", 
				this.Identifier == 0 ? "RegKey" : this.Identifier, 
				"create", arguments);
			return fromID(id);
		}
	
		public function open(keyName:String):RegKey {
			var id:Number = ExternalInterface.call("ffish_call", 
				this.Identifier == 0 ? "RegKey" : this.Identifier, 
				"open", keyName);
			return fromID(id);
		}
		
		public function getValues():Array {
			var values:Array = ExternalInterface.call("ffish_call", this.Identifier, 
				"getValues");
			var ret:Array = new Array();
			for (var i:Number = 0; i < values.length; i++) {
				var rv:RegValue = new RegValue(values[i]);
				ret.push(rv);
			}
			
			return ret;
		}
	
		public function getValue(...arguments):RegValue	{
			var id:Number = ExternalInterface.call("ffish_call2", this.Identifier, 
				"getValue", arguments);
			return new RegValue(id);
		}
	
		public function clone():RegKey {
			if (this.Identifier == 0) return fromID(0);		
			var id:Number = ExternalInterface.call("ffish_call", 
				this.Identifier, "clone");
			return fromID(id);
		}
	}
}