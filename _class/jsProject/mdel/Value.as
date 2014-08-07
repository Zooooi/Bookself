package jsProject.mdel 
{
	
	import mx.collections.ArrayCollection;

	/**
	 * ...
	 * @author ...
	 */
	public class Value 
	{
		//预设－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
		[Bindable]public static var bStageSize:Boolean = !SystemOS.isAndroid();
		private static var bStageResizeIOS:Boolean = true;
		private static var bStageResizeARM:Boolean = false;
		
		[Bindable]public static var bEdit_Page_Content:Boolean
		
		
		[Bindable]public static var nToolBarY:uint = 10;
		[Bindable]public static var nToolBarH:uint;
		
		[Bindable]public static var nZoom:Number=0;
		[Bindable]public static var nZoomMax:Number=0;
		[Bindable]public static var nZoomMin:Number=0;
		
		//顯示預覽
		[Bindable]public static var bShowPreviewPro:Boolean
		[Bindable]public static var bShowPreviewOpen:Boolean
		
		[Bindable] private static var aNumberText:ArrayCollection
		
		[Bindable]public static var bNewVersion:Boolean = true;
		
		public static var sUrl:String = "http://www.hkep.com/jr123/PTH"
	
			
		public static const aFunction:ArrayCollection = new ArrayCollection(
			[
				{id:NameDefine.COM_OPEN_HTML,name:"Open Html"},
				{id:NameDefine.COM_OPEN_APP,name:"Open APP"},
				{id:NameDefine.COM_OPEN_DOC,name:"Open DOC"},
				{id:NameDefine.COM_OPEN_XLS,name:"Open XLS"},
				{id:NameDefine.COM_OPEN_PPT,name:"Open PPT"},
				{id:NameDefine.COM_OPEN_PDF,name:"Open PDF"},
				{id:NameDefine.COM_OPEN_FILE,name:"Open FILE"},
				{id:NameDefine.COM_PLAY_SND,name:"Play Sound"},
				{id:NameDefine.COM_PLAY_MOV,name:"Play Movie"},
				{id:NameDefine.COM_SHOW_PIC,name:"Show Picture"},
				{id:NameDefine.COM_SHOW_OTHER,name:"OTHER"}
			]
		);
		
		
		
		
		public static function setPageNumberArray(_xmlPage:XMLList):void
		{
			var _atext:ArrayCollection = new ArrayCollection
			var _object:Object
			_object = new Object
			_object.id = ""
			_object.name = ""
			_atext.addItem(_object)
				
			for (var i:int = 0; i < _xmlPage.children().length(); i++) 
			{
				var _node:XMLList = XMLList(_xmlPage.children()[i])
				var _number:String = _node.text.pageNumber
				_object = new Object
				_object.id = i + 1
				_object.name = (i + 1)+": ("+_node.@unit+"-"+_node.@chapter+")  " + _node.@pageID
				_object.content = _number
				_object.pageID = _node.@pageID
				_object.chapter = _node.@chapter
				_object.unit = _node.@unit
				_atext.addItem(_object)
			} 
			aNumberText = _atext
		}
		
		
		public static function get aPageNumber():ArrayCollection
		{
			return aNumberText
		}
		
		
		public static function getPageNumber(_id:uint,_name:String="content"):String
		{
			var _out:String =""
			if (_id<aNumberText.length)
			{
				_out = aNumberText[_id][_name]
			}else{
				_out = ""
			}
			return _out
		}
	}

}