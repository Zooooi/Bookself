package jsProject.view
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class SubGroup_ShowHideNormal extends SubGroup_ShowHideBase
	{
		
		public function SubGroup_ShowHideNormal()
		{
			super();
		}
		
		
		override protected function onUnitMouseEvent(event:MouseEvent):void
		{
			var _me:IconButtonSprite = IconButtonSprite(event.currentTarget)
			var _index:uint = _me.index
			var _b:Boolean = !aClick[_index]
			aClick[_index] = _b
			
			getCurrentLangugeXML(_index)
			for (var i:int = 0; i < aButtons[_index].length; i++) 
			{
				var _data:SubGroup_ButtonData = aButtons[_index][i]
				_data.state = _b
				
				if (currentLangugeXML.@active == "1")
				{
					_data.btn.mouseChildren = _b
					_data.btn.mouseEnabled = _b
					if (!_b)
					{
						aSmallClick[_index][i]=_b
						setAlphaByBoolean(_data.btn,_b)
					}
				}else{
					aSmallClick[_index][i]=_b
					setAlphaByBoolean(_data.btn,_b)
				}
			}
			_me.select(!_me.getSelected())
		}
		
		
		override protected function setupShapeButton(_btn:Sprite):void
		{
			super.setupShapeButton(_btn)
			_btn.addEventListener(MouseEvent.CLICK,onSmallMouseEvent)
		}
		
		
		
	}
}