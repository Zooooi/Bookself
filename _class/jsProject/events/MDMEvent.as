package jsProject.events 
{
	import flash.events.Event;
	
	public class MDMEvent extends Event
	{
		public static const INIT:String = "INIT"
		
		public function MDMEvent(type:String){
			super(type);
		}
		
		
	}

}