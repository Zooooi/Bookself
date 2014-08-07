package JsC.events
{
	import mx.controls.listClasses.BaseListData;
	
	import JsC.events.BaseEvent;
	
	
	public class DataGrid2Event extends BaseEvent
	{
		
		public static const SEND:String  = "SEND" //發送XML
		public static const CHANGE:String  = "CHANGE" //發送XML
			
		public var $listData:BaseListData
		public var $selectItem:Object
		public var $dataField:String
		public var $label:String
		public var $color:uint
		public var $alpha:Number
		
		
		public function DataGrid2Event(type:String)
		{
			super(type);
		}
	}
}