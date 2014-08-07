package JsC.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class JEffectEvent extends Event
	{
		public static const Drag_Stop:String = "Drag_Stop"
		public static const Drag_Start:String = "Drag_Start"
		public static const Drag_Resume:String = "Drag_Resume"
		public static const Drag_Refresh:String = "Drag_Refresh"
			
		public static const END:String = "END"
		public static const STOP:String = "STOP"
		public static const UPADTE:String = "UPADTE"
		public static const COMPLETE:String = "COMPLETE"
		public static const START:String = "START"
		public static const MIN:String = "MIN"	
		public static const MAX:String = "MAX"	
		
		public function JEffectEvent(type:String){
			super(type);
		}
		
		
		
	}

}