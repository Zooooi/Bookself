package SWFKit
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.external.*;

	public dynamic class Global extends Proxy
	{
		static public function eval(expr: String)
		{
			return ExternalInterface.call("eval", expr);
		}
		
		static public function trace(message: String)
		{
			return ExternalInterface.call("trace", message);
		}
		
		static public function createControl(progID, left, top, right, bottom, 
											 params, licenseKey)
		{
			var axc = ExternalInterface.call("createControl", progID, 
												   left, top, right, bottom, 
												   params, licenseKey);
			if (axc == null) return null;
			return new AXControl(axc);
		}
		
		static public function getMainWnd()
		{
			var window = ExternalInterface.call("getMainWnd");
			return new SWFKit.Window(window);
		}
		
		static public function getAppDir()
		{
			return ExternalInterface.call("getAppDir");
		}
		
		static public function setWindowless(value)
		{
			ExternalInterface.call("setWindowless", value);
		}
		
		static public function readProfile(section, entry)
		{
			return ExternalInterface.call("readProfile", section, entry);
		}
		
		static public function writeProfile(section, entry, value)
		{
			ExternalInterface.call("writeProfile", section, entry, value);
		}
		
		static public function processMsg()
		{
			return ExternalInterface.call("processMsg");
		}
		
		static public function getAdditionalFile(filename)
		{
			return ExternalInterface.call("getAdditionalFile", filename);
		}
		
		static public function getExeName()
		{
			return ExternalInterface.call("getExeName");
		}
		
		static public function invoke(name)
		{
			ExternalInterface.call("invoke", name);
		}
		
		static public function evals(filename)
		{
			ExternalInterface.call("evals", filename);
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):* {
			args.unshift(methodName.toString());
        	return ExternalInterface.call.apply(ExternalInterface, args);
    	}
	}
}