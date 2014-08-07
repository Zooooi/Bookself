package JsC.shell
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import JsC.mdel.SystemOS;
	
	import jsProject.events.ComponentEvent;
	import jsProject.mdel.Value;

	public class ShellAction
	{
		public function ShellAction()
		{
		}
		
		public static function GoWeb(_current:Object,_url:String):void
		{
			if (SystemOS.isMobile)
			{
				var _event:ComponentEvent = new ComponentEvent(ComponentEvent.OPEN_HTML)
				_event._url = Value.sUrl
				_current.dispatchEvent(_event)
			}else{
				navigateToURL(new URLRequest(_url))
			}
		}
	}
}