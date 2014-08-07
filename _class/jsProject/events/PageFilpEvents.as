package jsProject.events
{
	import JsC.events.BaseEvent;
	
	import flash.display.Sprite;
	
	import jsProject.mdel.PageFlipContent;

	/**
	 * ...
	 * @author ...
	 */
	public class PageFilpEvents extends BaseEvent
	{
		public static const onLoadInit:String = "onLoadInit" //初始
		public static const onLoading:String = "onLoading" //正在下载
		public static const onLoaded:String = "onLoaded" //底图下载完毕
		public static const onPageFlipEnd:String = "onPageFlipEnd" //翻页完毕
		public static const onPagePlaying:String = "onPagePlaying" //正在翻页
		public static const onResetLoc:String = "onResetLoc" //重置位置
		public static const onGoToPageError:String = "onGoToPageError" //重置位置
		public static const onRemoveAction:String = "onRemoveAction" 
		
			
		public var $nPage:uint
		public var $currentPageLoader:PageFlipContent
		public var $currentPageContent:Sprite
		
		public function PageFilpEvents(type:String) 
		{
			super(type);
		}
		
	}

}