package SWFKit.application {

	import SWFKit.BaseObj;
	import SWFKit.Image;
	import flash.external.*;

	public dynamic class clipboard extends BaseObj {
		public function clipboard() {
			super.fnBaseObjByName("_Clipboard_");
		}
		
		public function pasteBitmap():SWFKit.Image {
			var bmp:Number = ExternalInterface.call("ffish_call", "_Clipboard_", 
				"pasteBitmap");
			return SWFKit.Image.FromID(bmp);
		}
	}
}