package jsProject.view
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class SubGroup_ShowHideSlider extends SubGroup_ShowHideBase
	{
		
		private var aCount:Vector.<uint>
		public function SubGroup_ShowHideSlider()
		{
			aCount = new Vector.<uint>
			super();
		}
		
		override protected function setupUnitButton(_btn:IconButtonSprite):void
		{
			super.setupUnitButton(_btn);
			aCount.push(0)
		}
		
		override protected function onUnitMouseEvent(event:MouseEvent):void
		{
			var _me:IconButtonSprite = IconButtonSprite(event.currentTarget)
			var _index:uint = _me.index
			var _b:Boolean = !aClick[_index]
			var _data:SubGroup_ButtonData
			if (aCount[_index]< aButtons[_index].length)
			{
				_data = aButtons[_index][aCount[_index]]
				_data.state = _b
				aSmallClick[_index][aCount[_index]]=_b
				setAlphaByBoolean(_data.btn,_b)
				aCount[_index]++
			}else if (aCount[_index] >= aButtons[_index].length){
				_b = !_b
				aCount[_index] = 0
				for (var i:int = 0; i < aButtons[_index].length; i++) 
				{
					_data = aButtons[_index][i]
					_data.state = _b
					aSmallClick[_index][i]=_b
					setAlphaByBoolean(_data.btn,_b)
				}
			}
		}
		
		override protected function onPlayAllMouseEvent(event:MouseEvent):void
		{
			for (var i:int = 0; i < aCount.length; i++) 
			{
				aCount[i]=0
			}
			super.onPlayAllMouseEvent(event)
		}
		
		
		override protected function setupShapeButton(_btn:Sprite):void
		{
			super.setupShapeButton(_btn)
			_btn.mouseChildren = false
			_btn.mouseEnabled = false
		}
		
	}
}