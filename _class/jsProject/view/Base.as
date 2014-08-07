package jsProject.view 
{
	import JsC.loader.GetLoader;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	
	 [Event(name = "onComplete", type = "JsC.events.JEvent")]
	 [Event(name = "onRefresh", type = "JsC.events.JEvent")]
	 
	public class Base extends Sprite
	{
		protected var xml:XML
		protected var xmlList:XMLList
		protected var JsLoader:GetLoader
		protected var me:Sprite
		
		public function Base() 
		{
			JsLoader = new GetLoader()
		}
	
	
		
	}

}