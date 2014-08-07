package jsProject.mdel
{
	import flash.display.Loader;
	import flash.display.Sprite;
	
	import jsProject.view.PageCtrlLayer;
	import jsProject.view.PageDrawLayer;
	
	public class PageFlipContent extends Sprite
	{
		public var id:uint
		public var loadedflag:Boolean
		public var loadedtype:String
		public var brotherMC:PageFlipContent
		public var isWidthPage:Boolean
		public var loader:Loader
		public var minScale:Number
		public var maxScale:Number
		public var nPage:uint
		
		
		public function PageFlipContent()
		{
			super();
		}
		
		
		public function $getDrawLayer():PageDrawLayer
		{
			return PageDrawLayer(getChildByName(NameDefine.KEY_DRAWER))
		}
		
		public function $getCtrlLayer():PageCtrlLayer
		{
			return PageCtrlLayer(getChildByName(NameDefine.KEY_COMPONENTS_KEY))
		}
		
		public function $getPageNumber():uint
		{
			return nPage
		}
		
		
	}
}