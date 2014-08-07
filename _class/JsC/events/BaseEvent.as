package JsC.events 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author 123
	 */
	public class BaseEvent extends Event
	{
		
		protected var OBJECT:Object
		protected var ID:uint
		protected var INDEX:uint
		protected var FUNCTION:Function
		protected var BOOLEAN:Boolean
		protected var NUMBER:Number
		protected var STRING:String
		protected var SPRITE:Sprite
		protected var xml:XML
		protected var event:Event
		
		public var _x:Number
		public var _y:Number
		public var _z:Number
		public var _l:Number
		public var _t:Number
		public var _width:Number
		public var _height:Number
		public var _url:String
		public var _path:String
		public var _name:String
		public var _file:String
		public var _id:int = -1
		public var _num:int
		public var _level:int
		public var _xml:XML
		
		public function BaseEvent(type:String) 
		{
			super(type);
		}
		
		public function $setID(_id:uint):void
		{
			ID = _id
		}
		
		
		public function $getID():uint
		{
			return ID
		}
		
		public function $setIndex(_id:uint):void
		{
			INDEX = _id
		}
		
		
		public function $getIndex():uint
		{
			return INDEX
		}
		
		public function $setNum(_id:Number):void
		{
			NUMBER = _id
		}
		
		
		public function $getNum():Number
		{
			return NUMBER
		}
		
		
		public function $setFunction(_fuction:Function):void
		{
			FUNCTION = _fuction
		}
		
		
		public function $getFuction():Function
		{
			return FUNCTION
		}
		
		
		public function $setObject(_object:Object):void
		{
			OBJECT = _object
		}
		
		public function $getObject():Object
		{
			return OBJECT
		}
		
		
		public function $setBoolean(_boolean:Boolean):void
		{
			BOOLEAN = _boolean
		}
		
		public function $getBoolean():Boolean
		{
			return BOOLEAN
		}
		
		
		public function $setXML(_xml:XML):void
		{
			xml = _xml
		}
		
		public function $getXML():XML
		{
			return xml
		}
		
		public function $setEvent(_value:Event):void
		{
			event = _value
		}
		
		public function $getEvent():Event
		{
			return event
		}
		
		public function $setString(_value:String):void
		{
			STRING = _value
		}
		
		public function $getString():String
		{
			return STRING
		}
		
		public function $setSprite(_value:Sprite):void
		{
			SPRITE = _value
		}
		
		public function $getSprite():Sprite
		{
			return SPRITE
		}
		
		
		
	}

}