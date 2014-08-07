package jsProject.view
{
	import JsC.events.JEvent;
	import JsC.mouse.ToolTip;
	
	import components.symbol.bookUi.UIAddBookMarkPanel;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import jsProject.mdel.Viewers;
	
	import mx.core.UIComponent;
	
	public class UIAddBookMarkButton extends BaseUIButton
	{
		
		[Embed(source="embed/button/ui/bookmark.png")]
		private var PicClass:Class;
		
		
		public function UIAddBookMarkButton()
		{
			var _bitmap:Bitmap = new PicClass
			_bitmap.width = cW
			_bitmap.height = cH
			addChild(_bitmap)
			width = _bitmap.width
			height = _bitmap.height
			addEventListener(JEvent.CLICK,onClick)
		}
		
		
		protected function onClick(event:Event):void
		{
			var note:UIAddBookMarkPanel = new UIAddBookMarkPanel
			note.$setData(this)
			Viewers.getPage().addUI(note)
		}
	
	}
}