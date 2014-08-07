package SWFKit {
	
	import flash.external.*;
	
	public dynamic class RecvMail extends BaseObj {
		public function RecvMail() {
			super.fnBaseObjByName("RecvMail");
		}
		
		public function retr(index:Number):Mail {
			var id:Number = ExternalInterface.call("ffish_call", this.Identifier, 
				"retr", index);
			return new SWFKit.Mail(id);
		}
	}
}