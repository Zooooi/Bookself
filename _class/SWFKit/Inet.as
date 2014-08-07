package SWFKit {
	
	import flash.external.*;
	import SWFKit.inet.Ftp;
	
	public dynamic class Inet extends BaseObj {
		public function Inet() {
			super.fnBaseObjByName("Inet");
		}
		
		public function getIPConfig():IPConfig {
			var id:Number = ExternalInterface.call("ffish_call", this.Identifier, 
				"getIPConfig");
			return new SWFKit.IPConfig(id);
		}
		
		public static function openFtp(...args):SWFKit.inet.Ftp {
			var id:Number = ExternalInterface.call("ffish_call2", "Inet", 
				"openFtp", args);
			return new SWFKit.inet.Ftp(id);
		}
	}
}