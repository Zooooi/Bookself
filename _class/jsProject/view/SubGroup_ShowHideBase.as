package jsProject.view
{
	import components.symbol.Buttons.IconButton;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;

	public class SubGroup_ShowHideBase extends SubGroupBase
	{
		public function SubGroup_ShowHideBase()
		{
			super()
		}
		
		override protected function inst():void
		{
			defAlpha = 1
			if (myXML.@defalutDisplay =="1")
			{
				bAct = true
			}else{
				bAct = false
			}
			aSmallClick= new Vector.<Vector.<Boolean>>
			aClick = new Vector.<Boolean>
			super.inst()
		}
		
		
		override protected function setupUnitButton(_btn:IconButtonSprite):void
		{
			aClick .push(bAct)
			_btn.select(!bAct)
			aSmallClick.push(new Vector.<Boolean>)
			_btn.addEventListener(MouseEvent.CLICK,onUnitMouseEvent)
		}
		
		override protected function onPlayAllMouseEvent(event:MouseEvent):void
		{
			bPlayAllState = !bPlayAllState
			var i:int
			for (i; i < aBigButton.length; i++) 
			{
				aClick[i] = bPlayAllState
				aBigButton[i].select(!bPlayAllState)
			}
			
			for (i = 0; i < aButtons.length; i++) 
			{
				for (var j:int = 0; j < aButtons[i].length; j++) 
				{
					aButtons[i][j].state = bPlayAllState
					setAlphaByBoolean(aButtons[i][j].btn,bPlayAllState)
				}
			}
		}
		
		override protected function setupShapeButton(_btn:Sprite):void
		{
			if (bAct)
			{
				_btn .alpha = 1
			}else{
				_btn .alpha = 0
			}
			aSmallClick[aSmallClick.length-1].push(false)
			if (currentParaXML.@file!="")
			{
				getCurrentShapeXML(0)
				var _bit:IconBitmap = new IconBitmap(sPath + currentParaXML.@file,uint(currentShapeXML.@width),uint(currentShapeXML.@height))
				_bit.x = Number(currentShapeXML.@x)
				_bit.y = Number(currentShapeXML.@y)
				_btn.getChildAt(0).alpha = 0
				_btn.addChild(_bit)
			}
		}
		
		
		protected function onUnitMouseEvent(event:MouseEvent):void
		{
			
		}
		
		
	
		
		
		protected function onSmallMouseEvent(event:MouseEvent):void
		{
			var _me:Sprite = Sprite(event.currentTarget)
			var _b:Boolean 
			var _c:Boolean
			if (_me.alpha==1)
			{
				_b = true
				_me.alpha = 0
				
			}else{
				_b = false
				_me.alpha = 1
			}
			var _ve:Vector.<uint> = searchSmallID(_me)
			var _l:uint = _ve[0]
			aSmallClick[_l][_ve[1]] = _b
			for (var i:int = 0; i < aSmallClick[_l].length; i++) 
			{
				if ( !aSmallClick[_l][i]== aClick[_l])
				{
					_c = true
				}
			}
			
			if (_c == false)
			{
				var bb:IconButtonSprite = aBigButton[_l]
				bb.select(!bb.getSelected())
				aClick[_l] = !_b
			}
		}
		
		
		protected function setAlphaByBoolean(_me:Sprite,_b:Boolean):void
		{
			var _b:Boolean
			if (_b)
			{
				_me.alpha = 1
			}else{
				_me.alpha = 0
			}
		}
	}
}