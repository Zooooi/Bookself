package jsProject.view
{
	import JsC.xml.XmlCtrl;
	
	import flash.display.Sprite;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.ViewerControls;
	import jsProject.mdel.Viewers;
	import jsProject.mdel.XmlContent;

	public class PageCtrlLayer extends Sprite
	{
		
		private const xmlComponent:XML = XmlContent.XML_COMPONENT
		private const sPath:String = Files.folder_components
			
		private var nodeCtrl:XMLList
		private var nPage:uint
		
		public function PageCtrlLayer(_pageNum:uint) 
		{
			name = NameDefine.KEY_COMPONENTS_KEY
			nPage = _pageNum
			nodeCtrl = XmlContent.getCurrentCtrlNode(nPage)
			
			var _xmlListComponent:XMLList 
			var _xml:XML
			var i:int
			
			
			for (i = 0; i < nodeCtrl.children().length(); i++) 
			{
				_xml = XmlContent.updataComponent(nodeCtrl.children()[i].@componentID,nodeCtrl.children()[i])
				var _item:IconComponent = new IconComponent
				_item.$setData(Files.folder_components,_xml)
				addChild(_item)
			}
			
			
			//addUserButton(XmlCtrl.getNodeByName(XMLList(XmlContent.XML_USER),NameDefine.KEY_USER_BOOKMARK),UIAddBookMarkButton	)
			addUserButton(XmlCtrl.getNodeByName(XMLList(XmlContent.XML_USER),NameDefine.KEY_USER_NOTE),UINoteButton)
			addUserButton(XmlCtrl.getNodeByName(XMLList(XmlContent.XML_USER),NameDefine.KEY_USER_RESOURCE),UIResourceButton)
			
		}
		
		
		private function addUserButton(_xmllist:XMLList,_class:Class):void
		{
			var i:int
			var _button:BaseUIButton
			for (var j:int = 0; j < _xmllist.children().length(); j++) 
			{
				var _node:XMLList = XMLList(_xmllist.children()[j])
				if (_node.@page == String(nPage+1))
				{
					_button = new _class
					_button.$setData(XMLList(_xmllist.children()[j]))
					_button.$LoadAction()
					addChild(_button)
					
					if (_class == UIResourceButton)
					{
						ViewerControls.addResourceButton(_button)
					}
					
				}
			}
			
		}
		
		
		public function getPageNo():uint
		{
			return nPage
		}
	}
}