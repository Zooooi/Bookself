package SWFKit {
	import flash.external.*;
	
	public dynamic class Menu extends BaseObj {
		public function Menu() {
			super.fnBaseObjByName("Menu");
		}
		
		public static function FromID(id:Number):Menu {
			var m:Menu = new Menu;
			m.Release();
			m.Identifier = id;
			return m;
		} 
		
		public function getSubMenu(pos:Number):Menu {
			var menu:Number = ExternalInterface.call("ffish_call", 
				this.Identifier, "getSubMenu", pos);
			return Menu.FromID(menu);
		}
	}
}