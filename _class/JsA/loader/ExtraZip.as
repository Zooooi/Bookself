package JsA.loader
{
	import flash.events.EventDispatcher;
	
	
	public class ExtraZip extends EventDispatcher
	{
		
		public function ExtraZip()
		{
			
		}
		
		
		public function start(zipfile:String,path:String):void
		{
			trace(zipfile)
		}
		
		public function startByStep(zipfile:String,path:String):void
		{
			trace(zipfile)
		}
		public function close():void
		{
			
		}
		
		
		
		
	}
}