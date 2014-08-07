package JsC.shell
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.system.Capabilities;
	
	import JsA.shell.AirShell;
	
	import JsC.events.JEvent;
	import JsC.mdel.SystemOS;

	
	[Event(name="COMPLETE", type="JsC.events.JEvent")]
	[Event(name="IOERROR", type="JsC.events.JEvent")]
	public class ShellSystem extends EventDispatcher 
	{
		private var file:FileReference
		protected static var shell:BaseShellSystem
		
		public function ShellSystem()
		{
			
		}
		
		public static function init():void
		{
			SystemOS.init()
			trace(Capabilities.playerType);
			switch(Capabilities.playerType)
			{
				case "StandAlone":
					shell = new AsShell
					break;
				case "Desktop": 
					shell = new AirShell
					break
				case "ActiveX":
					shell = new SWFK
					break;
			}
			shell.setAppPath()
		}
		
		public static function get current():BaseShellSystem
		{
			return shell
		}
		
	
	
		public function selectFile(_str:String,_type:String="XML (*.xml)"):void
		{
			var type:FileFilter = new FileFilter(_type,_str);
			var allTypes:Array = new Array(type); 
			file = new FileReference(); 
			file.addEventListener(Event.SELECT, onSelect);
			file.addEventListener(Event.COMPLETE, onXMLLoaded);
			file.browse(allTypes)
		}
		
		private function onSelect(event:Event) : void
		{  
			file.load()
		}
		
		private function onXMLLoaded(event:Event):void
		{
			var fileReference:FileReference=FileReference(event.target);
			var _event:JEvent = new JEvent(JEvent.COMPLETE)
			_event.$setString(fileReference.data.toString())
			dispatchEvent(_event)
		}
	}
}