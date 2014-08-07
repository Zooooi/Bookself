package SWFKit {
	
	import flash.external.*;
	
	public dynamic class Image extends BaseObj {
		public function Image() {
			super.fnBaseObjByName("Image");
		}
		
		public static function FromID(Id:Number):SWFKit.Image {
			var img:SWFKit.Image = new SWFKit.Image;
			img.Release();
			img.Identifier = Id;
			return img;
		}
		
		public static function load(...args):Image {
			var id:Number = ExternalInterface.call("ffish_call2", "Image", 
				"load", args);
			return Image.FromID(id);
		}
		
		public static function captureScreen(...args):Image {
			var id:Number = ExternalInterface.call("ffish_call2", "Image", 
				"captureScreen", args);
			return Image.FromID(id);
		}
		
		public static function captureMovie(...args):Image {
			var id:Number = ExternalInterface.call("ffish_call2", "Image", 
				"captureMovie", args);
			return Image.FromID(id);
		}
	}
}