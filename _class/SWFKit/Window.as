package SWFKit {
	import flash.external.*;
		
	public dynamic class Window extends BaseObj {
		public function Window(id: Number) {
			super.fnBaseObjByID(id);
		}
		
		public function get parent():Window {
			var window:Number = ExternalInterface.call("ffish_getprop", 
				this.Identifier, "parent");
			return new SWFKit.Window(window);
		}
		
		public function getChildren():Array	{
			var arr:Array = ExternalInterface.call("ffish_call", this.Identifier, 
				"getChildren");
			var winArray:Array = new Array();
			for (var i:Number = 0; i < arr.length; i++) {
				winArray.push(new SWFKit.Window(arr[i]));
			}
			
			return winArray;
		}
	
		public static function getWindowsByName(...arguments):Array {
			var arr:Array = ExternalInterface.call("ffish_call2", 
				"Window", "getWindowsByName", arguments);
		
			var winArray:Array = new Array();
			for (var i:Number = 0; i < arr.length; i++) {
				winArray.push(new SWFKit.Window(arr[i]));
			}
			
			return winArray;
		}
	
		public static function find(...arguments):Window {
			var window:Number = ExternalInterface.call("ffish_call2", "Window", 
				"find", arguments);
			return new SWFKit.Window(window);
		}
	}
}