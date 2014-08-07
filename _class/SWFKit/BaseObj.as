package SWFKit {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.external.*;
	
	public dynamic class BaseObj extends Proxy {
		public var Identifier: Number;
		
		public function fnBaseObjByName(objName:String):void {
			var ret:* = ExternalInterface.call("ffish_new", objName);
			if (ret == null || ret == undefined) this.Identifier = 0;
			else this.Identifier = ret;
		}
		
		public function fnBaseObjByID(id: Number):void {
			this.Identifier = id;
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):* {
        	return ExternalInterface.call("ffish_call2", this.Identifier,
										  String(methodName), args);
    	}

	    override flash_proxy function getProperty(name:*):* {
        	return ExternalInterface.call("ffish_getprop", this.Identifier,
										  String(name));
    	}

    	override flash_proxy function setProperty(name:*, value:*):void {
        	ExternalInterface.call("ffish_setprop", this.Identifier, 
        						   String(name), value);
    	}

		public function IsValid(): Boolean
		{
			return this.Identifier != 0;
		}
	
		public function Release(): void
		{
			ExternalInterface.call("ffish_delete", this.Identifier);
		}
	
		public function setEventHandler(event: String, handler:Function):void
		{
			var handlerName:String = "_" + this.Identifier + "_" + event;
			ExternalInterface.addCallback(handlerName, handler);
			ExternalInterface.call("ffish_seh", this.Identifier, event, handlerName);
		}
		
		public function getObject():Object {
			var obj:Object = new Object;
			obj.Identifier = this.Identifier;
			return obj;
		}
	}
}