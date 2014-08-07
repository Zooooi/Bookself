package jsProject.view
{
	import JsC.events.JEvent;
	
	import components.symbol.bookUi.UINotesPanel;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import jsProject.mdel.Viewers;
	
	public class UINoteButton extends BaseUIButton
	{
		
		[Embed(source="embed/button/ui/notectrlbutton.png")]
		private var PicClass:Class;
		
		
		public function UINoteButton()
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
			var note:UINotesPanel = new UINotesPanel
			note.$setData(this)
			Viewers.getPage().addUI(note)
		}
		
	
	}
}