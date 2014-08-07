package JsC.mouse
{
	import flash.display.MovieClip;
	import flash.display.Stage
	import flash.events.Event
	import flash.events.MouseEvent
	import flash.ui.Mouse
	/**
	 * ...
	 * @author ...
	 */
	public class Cursor 
	{
		private  static var _root:MovieClip
		private  static var _cursor:MovieClip
		
		public function Cursor () {
			
		}

		public static function Init(_local:MovieClip, _cursor_:MovieClip) 
		{
			_root = MovieClip(_local.root)
			_cursor = _cursor_
			_cursor.mouseEnabled=false
			_root.addChild(_cursor)
			_cursor.visible = false
			_local.addEventListener(Event.REMOVED_FROM_STAGE,remove)
		}
		public static function Show(_local:MovieClip=null) {
			//if (_cursor == null) Init(_local)
			Mouse.hide()
			_cursor.visible=true
			_cursor.gotoAndStop(1)
			_cursor.x = _root.mouseX
			_cursor.y = _root.mouseY
			_cursor.addEventListener(Event.ENTER_FRAME, onEnterFrame)
			if (!_root.stage.hasEventListener("onMouseEvent")){
				_root.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent)
				_root.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent)
			}
		}
		public static function Hide() {
			Mouse.show()
			_cursor.visible=false
			if (_cursor.hasEventListener(Event.ENTER_FRAME)) _cursor.removeEventListener(Event.ENTER_FRAME, onEnterFrame)
		}
		public static function remove(event:Event) {
			for (var nP:uint = 0; nP < _root.numChildren; nP++) {
				if (_root.getChildAt(nP) === _cursor) {
					_root.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent)
					_root.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseEvent)
					_root.removeChild(_root.getChildAt(nP))
					_cursor = null
				}
			}

		}
		private static function onEnterFrame(event:Event) {
			event.target.x = _root.mouseX
			event.target.y = _root.mouseY
		}
		private static function onMouseEvent(event:MouseEvent) {
			switch(event.type) {
				case MouseEvent.MOUSE_DOWN:
					_root.setChildIndex(_cursor,_root.numChildren-1)
					_cursor.gotoAndStop(2)
					break
				case MouseEvent.MOUSE_UP:
					_cursor.gotoAndStop(1)
					break
			}
		}
	}
	
}