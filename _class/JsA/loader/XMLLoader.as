package JsA.loader
{
	import JsC.events.JEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="ONECOMPLETE", type="JsC.events.JEvent")]
	[Event(name="ALLCOMPLETE", type="JsC.events.JEvent")]
	
	public class XMLLoader extends EventDispatcher
	{
		[Bindable]public var aLoaderPath:Array
		[Bindable]public var aValue:Array;
		
		private var xmlLoader:HTTPService
		private var nCount:uint
		private var nLength:uint
		
		public function XMLLoader()
		{
			
		}
		
		public function start():void
		{
			nCount = 0
			nLength = Math.min(aLoaderPath.length,aValue.length)
			xmlLoader = new HTTPService
			xmlLoader.resultFormat = "xml"
			xmlLoader.addEventListener(ResultEvent.RESULT,onReaultEvent)
			xmlLoader.addEventListener(FaultEvent.FAULT,onFault)
			run()
		}
		
		public function run():void
		{
			if (nCount < nLength)
			{
				xmlLoader.url = aLoaderPath[nCount]
				xmlLoader.send()
			}else{
				dispatchEvent(new JEvent(JEvent.ALLCOMPLETE))
			}
		}
			
		
		protected function onReaultEvent(event:ResultEvent):void
		{
			aValue[nCount] = new XML(event.result)
			nCount ++
			run()
		}		
		
		protected function onFault(event:FaultEvent):void
		{
			nCount ++
			run()
		}
	}
}