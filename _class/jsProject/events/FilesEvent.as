package jsProject.events
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 123
	 */
	public class FilesEvent extends BaseEvent
	{
		
		public static const Receive_Success:String = "Receive_Success"
		public static const Open_Success:String = "Open_Success"
		public static const Load_Success:String = "Load_Success"
		
		private var fileName:String
		
		public function FilesEvent(type:String)
		{
			super(type);
		}
		
		public function $getFileName():String
		{
			return fileName
		}
		
		
		public function $setFileName(_value:String):void
		{
			fileName = _value
		}
	}

}