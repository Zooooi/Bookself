package JsC.xml
{
	public class XmlCtrl
	{
		public static function addChild(_xmlParent:XMLList,_xmlChild:XMLList):XMLList
		{
			_xmlParent.appendChild(_xmlChild)
			return _xmlChild
		}
		
		public static function getChildrenByID(_xmlList:XMLList,_id:uint):XML
		{
			return _xmlList.children()[_id]
		}
		
		public static function getChildrenByNameID(_xmlList:XMLList,_name:String,_id:uint):XML
		{
			return _xmlList[_name][_id]
		}
		
		public static function getNodeAndCreate(_xmlList:XMLList,_name:String,_xml:XML=null):XMLList
		{
			var _node:XMLList = _xmlList
			if (_name!=null)
			{
				var _aName:Array = _name.split(".")
				for (var i:int = 0; i < _aName.length; i++) 
				{
					if (_node.child(_aName[i])==undefined) 
					{
						_node.appendChild(<{_aName[i]}/>)
					}
					_node = _node.child(_aName[i])
				}
			}
			return _node
		}
		
		public static function getNodeByName(_xmlList:XMLList,_name:String):XMLList
		{
			var _node:XMLList = _xmlList
			if (_name!=null)
			{
				var _aName:Array = _name.split(".")
				for (var i:int = 0; i < _aName.length; i++) 
				{
					if (_node.child(_aName[i])!=undefined) 
					{
						_node = _node.child(_aName[i])
					}else{
						break
					}
				}
			}
			return _node
		}
		
		public static function insertTo(_xmlParent:XMLList,_fID:uint,_tID:uint):void
		{
			var _xml:XML = _xmlParent.children()[_fID]
			delete _xmlParent.children()[_fID]
			if (_tID>=_xmlParent.children().length())
			{
				_xmlParent.appendChild(_xml)
			}else{
				_xmlParent.insertChildBefore(_xmlParent.children()[_tID],_xml)
			}
		}
		
		public static function deleteByID(_xmlList:XMLList,_id:uint):void
		{
			delete _xmlList.children()[_id]
		}
		
		public static function deleteList(_xmlList:XMLList):void
		{
			delete _xmlList.parent().children()[_xmlList.childIndex()]
		}
	
		
		
		public static function deleteAllChildren(_xmlList:XMLList):void
		{
			while(_xmlList.children().length()) delete _xmlList.children()[0]
		}
	}
	
	//xmlList.childIndex() 序号
	//xmlList.parent() 父
}