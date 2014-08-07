package jsProject.view
{
	import JsC.events.JEvent;
	import JsC.loader.GetLoader;
	
	import components.symbol.bookUi.UIAddBookMarkPanel;
	import components.symbol.bookUi.UIAddResourcePanel;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	
	import jsProject.ctrl.OpenComponentFiles;
	import jsProject.ctrl.PageDrag;
	import jsProject.mdel.Files;
	import jsProject.mdel.Viewers;
	
	import mx.core.UIComponent;
	
	public class UIResourceButton extends BaseUIButton
	{
		
		/*[Embed(source="/embed/button/ui/addResourcectrlbutton.png")]
		private var PicClass:Class;*/
		private var toolTip:String
		
		public function UIResourceButton()
		{
			addEventListener(JEvent.CLICK,onClick)
		}
		
		
		override public function $setData(_xmlList:XMLList):void
		{
			super.$setData(_xmlList)
			var _option:String = xList.@option
			var _url:String
			switch(_option)
			{
				default:
				case "0":
					_url = Files.folder_components + "addresource_icon_doc.png"
					break
				case "1":
					_url = Files.folder_components + "addresource_icon_web.png"
					break
			}
			var _getloader:GetLoader = new GetLoader
			_getloader.get(_url,{complete:onComplete,ioerror:onError})
			addEventListener(MouseEvent.ROLL_OVER,onMouseEvent2)
			addEventListener(MouseEvent.ROLL_OUT,onMouseEvent2)
		}
		
		private function onComplete(event:Event):void
		{
			var _bitmap:Bitmap = Bitmap(event.target.content)
			_bitmap.width = cW
			_bitmap.height = cH
			_bitmap.smoothing = true
			addChild(_bitmap)
			width = _bitmap.width
			height = _bitmap.height
			//trace(event)
		}
		
		private function onError(event:IOErrorEvent):void
		{
			
		}
		
		
		protected function onMouseEvent2(event:Event):void
		{
			var _parent:PageDrag = PageDrag(parent.parent.parent.parent)
			switch(event.type)
			{
				case MouseEvent.ROLL_OVER:
					var _option:String = xList.@option
					var _openfile:String = xList.@name
					_parent.toolTip = _openfile
					/*switch(_option)
					{
						default:
						case "0":
							if (_openfile=="")
							{
								toolTip = "no file"
							}else{
								toolTip = _openfile
							}
							break;
						
						case "1":
							toolTip = "website: " + _openfile
							break;
					}
					_parent.toolTip = toolTip*/
					break;
					
				case MouseEvent.ROLL_OUT:
					_parent.toolTip = ""
					break;
			}
			
		}
		
		protected function onClick(event:Event):void
		{
			new OpenComponentFiles(XML(xList),Files.folder_documentAssets)
			/*var note:UIAddResourcePanel = new UIAddResourcePanel
			note.$setData(this)
			Viewers.getPage().addUI(note)*/
		}
	
	}
}