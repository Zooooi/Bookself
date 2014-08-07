package jsProject.events
{
	import JsC.events.JEvent;

	public class ProjectEvent extends JEvent
	{
		//Info---------------------------------------------------------------------------
		public static const YES:String = "YES"
		public static const NO:String = "NO"
		public static const CANCEL:String = "CANCEL"
		public static const ALERT:String = "ALERT"	
		
		public function ProjectEvent()
		{
		}
	}
}