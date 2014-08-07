package jsProject.view
{
	import JsC.xml.XmlCtrl;
	
	import flash.display.Sprite;
	
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.PageFlipContent;
	import jsProject.mdel.XmlContent;

	public class PageUserButtonCtrl extends Sprite
	{
		public function PageUserButtonCtrl(loader:PageFlipContent,_page:uint)
		{
			var _layer:PageCtrlLayer = loader.$getCtrlLayer()
			var _xmllist:XMLList = XmlCtrl.getNodeByName(XMLList(XmlContent.Edit_USER),NameDefine.KEY_USER_BOOKMARK)
			trace(XmlContent.Edit_USER)
		}
	}
}