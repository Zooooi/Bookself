package jsProject.view
{
	import JsC.shell.ShellSystem;
	import JsC.sprite.Drawer;
	import JsC.string.Maths;
	import JsC.xml.XmlCtrl;
	
	import components.books.BookPage;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.Value;
	import jsProject.mdel.XmlContent;
	
	import mx.core.UIComponent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.primitives.Graphic;
	
	
	public class PageDrawLayer extends Sprite
	{
		private const cLayer:uint = 3
		private var layerMask:Sprite
		private var nW:uint
		private var nH:uint
		
		private var nPage:uint
		private var xmldata:XML = XmlContent.Edit_drawXML.copy()
		private var sFile:String
		
		private var palf:Sprite
		private var drawShape:Sprite 
	
		public function PageDrawLayer(_nPage:uint)
		{
			mouseEnabled = false
			mouseChildren = false
			name = NameDefine.KEY_DRAW_KEY
			addEventListener(Event.ADDED_TO_STAGE,onEvent)
			nPage = _nPage
			sFile = "draw"+Maths.Bits(nPage+1,3)//Value.getPageNumber(nPage+1,"pageID")
				
			palf = new Sprite
			palf.name = "draw"
			addChild(palf)
			
			
			var xmlLoader:HTTPService = new HTTPService
			xmlLoader.resultFormat = "xml"
			//trace(Files.folder_documentDrawing + sFile)
			xmlLoader.url = Files.folder_documentDrawing + sFile
			xmlLoader.addEventListener(ResultEvent.RESULT,onResultEvent)
			xmlLoader.addEventListener(FaultEvent.FAULT,onFault)
			xmlLoader.send()
		}
		
		protected function onEvent(event:Event):void
		{
			switch(event.type)
			{
				case Event.ADDED_TO_STAGE:
					if (layerMask==null)
					{
						nW = Sprite(parent).width
						nH = Sprite(parent).height
						layerMask = new Sprite
						layerMask.graphics.beginFill(0x000000, 0);
						layerMask.graphics.drawRect(0,0,nW,nH)
						layerMask.graphics.endFill()
						layerMask.mouseEnabled = false
						layerMask.mouseChildren = false
						addChild(layerMask)
						palf.mask = layerMask
						removeEventListener(Event.ADDED_TO_STAGE,arguments.callee)
					}
					break;
			}
		}
		
		protected function onFault(event:FaultEvent=null):void
		{
			xmldata=XmlContent.Edit_drawXML.copy()
		}
		
		protected function onResultEvent(event:ResultEvent):void
		{
			var _rs:String = String(event.result)
			xmldata = XmlContent.Edit_drawXML.copy()
				
			var _reg:RegExp = /<drawing>(.*)<\/drawing>/g
			if (_rs=="" || _rs.match(_reg)==null)
			{
				onFault()
			}else{
				xmldata = new XML(_rs)
			}
			loadedInit()
		}		
		
		private function loadedInit():void
		{
			for (var i:int = 0; i < xmldata.children().length(); i++) 
			{
				var _xml:XML = XmlCtrl.getChildrenByID(XMLList(xmldata),i)
				var _drawer:Drawer = new Drawer
				_drawer.drawFromXML(palf,_xml)
				
			}
		}
		
		
		
		public function $getHitArea():Sprite
		{
			return layerMask
		}
		
		public function $getWidth():uint
		{
			return nW
		}
		
		public function $getHeight():uint
		{
			return nH
		}
		
		public function $addXML(_xml:XML):void
		{
			XmlCtrl.addChild(XMLList(xmldata),XMLList(_xml))
			ShellSystem.current.saveDrawFile(xmldata,sFile)
		}
		
		public function $setLoc(_nodeNumber:uint,_x:Number,_y:Number):void
		{
			var _xmlList:XMLList = XMLList(XmlCtrl.getChildrenByID(XMLList(xmldata),_nodeNumber))
			_xmlList.@x = _x
			_xmlList.@y = _y
			ShellSystem.current.saveDrawFile(xmldata,sFile)
		}
		
		public function $delNode(_node:uint):void
		{
			palf.removeChildAt(_node)
			XmlCtrl.deleteByID(XMLList(xmldata),_node)
		}
		
		public function $delAll():void
		{
			while(palf.numChildren)palf.removeChildAt(0)
			xmldata = XmlContent.Edit_drawXML.copy()
			$saveNode()
		}
		
		public function $saveNode():void
		{
			ShellSystem.current.saveDrawFile(xmldata,sFile)
		}
	}
}