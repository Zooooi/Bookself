package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Form extends BaseObj {
		public function Form() {
			super.fnBaseObjByName("Form");
		}
		
		public static function fromID(id: Number):Form {
			var form:Form = new Form;
			form.Release();
			form.Identifier = id;
			return form;
		}
		
		public function get window():Window	{
			var win:Number = ExternalInterface.call("ffish_getprop", 
				this.Identifier, "window");
			return new SWFKit.Window(win);
		}
		
		public function createControl(...args):AXControl {
			var axc:Number = ExternalInterface.call("ffish_call2", this.Identifier, 
				"createControl", args);
			return new SWFKit.AXControl(axc);
		}
	}
}