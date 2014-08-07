package jsProject.view
{
	import JsC.events.JEvent;
	
	import components.symbol.bookUi.UIAddBookMark;
	import components.symbol.bookUi.UIAddResource;
	import components.symbol.bookUi.UINotes;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.TextFlow;
	
	import jsProject.ctrl.FileCtrl;
	import jsProject.mdel.Viewers;
	
	public class UIBookmarkButton extends BaseUIButton
	{
		
		[Embed(source="embed/button/ui/bookmark.png")]
		private var PicClass:Class;
		
		
		public function UIBookmarkButton()
		{
			var _bitmap:Bitmap = new PicClass
			addChild(_bitmap)
			width = _bitmap.width
			height = _bitmap.height
			addEventListener(JEvent.CLICK,onClick)
		}
		
		protected function onClick(event:Event):void
		{
			var note:UIAddResource = new UIAddResource
			note.$setData(this)
			Viewers.getPage().addUI(note)
		}
	
	}
}