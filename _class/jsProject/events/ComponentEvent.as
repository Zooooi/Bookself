package jsProject.events
{
	import JsC.events.BaseEvent;

	
	public class ComponentEvent extends BaseEvent
	{
		public static const OPEN_HTML:String = "OPEN_HTML"
		public static const OPEN_OFFICE:String = "OPEN_OFFICE"
		public static const OPEN_MOVIE:String = "OPEN_MOVIE"
		
		public var _currentPath:String
		public var _openfile:String
		public var _hasFolder:Boolean
		
		
		public function ComponentEvent(type:String){
			super(type);
		}
	}
}

