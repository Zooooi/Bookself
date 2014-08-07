package jsProject.view
{
	import JsC.events.JEvent;
	
	import SWFKit.Form;
	
	import caurina.TransData;
	import caurina.transitions.Tweener;
	
	import components.symbol.Tools.ToolMusic;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.Viewers;
	import jsProject.mdel.XmlContent;
	
	public class SubGroup_PlayList extends SubGroupBase
	{
		private const nDuration:Number=1;
		private const transition:String = TransData.easeinoutbounce
		
		private var playMode:String = mode_PlayOne
		private const mode_VOL:String = "VOL"
		private const mode_PlayAll:String = "mode_PlayAll"
		private const mode_PlayAllFORCE:String = "mode_PlayAll_Force"
		private const mode_PlayPara:String = "mode_PlayPara"
		private const mode_PlayOne:String = "mode_PlayOne"
			
		private var nPlaying:uint
		private var currentSprite:Sprite
		private var bPlayAll:Boolean
		
		private var toolsMusic:ToolMusic
		
		
		public function SubGroup_PlayList()
		{
			super();
			addEventListener(Event.REMOVED_FROM_STAGE,onEvent)
			toolsMusic = Viewers.getMusic()
		}
		
		protected function onEvent(event:Event):void
		{
			switch(event.type)
			{
				case Event.REMOVED_FROM_STAGE:
					if (currentSprite!=null) toolsMusic.$stop()
					stopAndRemove()
					break;
			}
		}
		
		override protected function inst():void
		{
			defBlend = BlendMode.MULTIPLY
			super.inst();
		}
		
		override protected function onPlayAllMouseEvent(event:MouseEvent):void
		{
			var _btn:IconButtonSprite = IconButtonSprite(event.currentTarget)
			_btn.select(true)
			if (_btn.$getXML().@force=="1")
			{
				playMode = mode_PlayAllFORCE
			}else{
				playMode = mode_PlayAll
			}
			aPlayList = aPlayAll
			doPlay(0)
		}
		
		override protected function onPlayKindMouseEvent(event:MouseEvent):void
		{
			var _me:IconButtonSprite = IconButtonSprite(event.currentTarget)
			var _index:uint = aKindButton.indexOf(_me)
			var _b:Boolean = !_me.getSelected()
			var _group:String = aGroupText[_index]
			_me.select(_b)
			var currentData:SubGroup_ButtonData
			for (var i:int = 0; i < _group.length; i++) 
			{
				if (_group.charAt(i)=="1")
				{
					for (var j:int = 0; j < aButtons[i].length; j++) 
					{
						currentData = aButtons[i][j]
						currentData.state = _b
						if (currentData.btn == currentSprite) 
						{
							playCases(currentData)
						}
					}
				}
				
			}
		}
		
		override protected function setupUnitButton(_btn:IconButtonSprite):void
		{
			_btn.addEventListener(MouseEvent.CLICK,onUnitMouseEvent)
		}
		
		override protected function setupShapeButton(_btn:Sprite):void
		{
			super.setupShapeButton(_btn)
			_btn.alpha = 0
			_btn.addEventListener(MouseEvent.CLICK,onPlayMouseEvent)
			_btn.addEventListener(MouseEvent.ROLL_OVER,onPlayMouseEvent)
			_btn.addEventListener(MouseEvent.ROLL_OUT,onPlayMouseEvent)
		}
		
		protected function onPlayMouseEvent(event:MouseEvent):void
		{
			var _me:Sprite = (Sprite(event.currentTarget))
			var _obj:SubGroup_ButtonData =searchObjectInLine(_me)
			switch(event.type)
			{
				case MouseEvent.CLICK:
					playMode = mode_PlayOne
					for (var i:int = 0; i < aPlayAllButton.length; i++) 
					{
						aPlayAllButton[i].select(false)
					}
					aPlayList = aPlayAll
					doPlay(_obj.index)
					break;
				case MouseEvent.ROLL_OVER:
					if (currentSprite!= _me) _me.alpha = 1
					break
				case MouseEvent.ROLL_OUT:
					if (currentSprite!= _me) _me.alpha = 0
					break
			}
		}		
		
		private function onSoundComplete(event:JEvent):void
		{
			var _obj:SubGroup_ButtonData
			switch(event.type)
			{
				case JEvent.SOUND_COMPLETE:
					switch(playMode)
					{
						case mode_PlayAllFORCE:
						case mode_PlayAll:
						case mode_PlayPara:
							if (nPlaying<aPlayList.length-1)
							{
								nPlaying++
								doPlay(nPlaying)
							}else 
							{
								stopAndRemove()
							}
							break;
						case mode_PlayOne:
							stopAndRemove()
							break;	
					}
					
					break;
				
				case JEvent.SOUND_UPDATE:
					if (searchObjectInLine(event._url)==null)
					{
						stopAndRemove()
					}
					break;
				
				case JEvent.SOUND_STOP:
					doStopEffect()
					break;
				
				case JEvent.SOUND_PLAY:
					_obj = searchObjectInLine(event._url)
					if (_obj!=null)
					{
						doPlayEffect(_obj.btn)
					}
					break;
			}
		}
		
		private function stopAndRemove():void
		{
			doStopEffect()
			removeEvent()
		}
		
		
		
			
		
		
		
		protected function onUnitMouseEvent(event:MouseEvent):void
		{
			playMode = mode_PlayPara
			var _me:IconButtonSprite = IconButtonSprite(event.currentTarget)
			var _index:uint = aBigButton.indexOf(_me)
			var _b:Boolean = (_me.getSelected())?false:true
			
			aPlayList = new Vector.<SubGroup_ButtonData>
			for (var i:int = 0; i < aButtons[_index].length; i++) 
			{
				aPlayList.push( aButtons[_index][i])
			}
			doPlay(0)
			
		}		
		
		protected function onKindMouseEvent(event:MouseEvent):void
		{
			
		}
		
		
		
		
		private function removeEvent():void
		{
			toolsMusic.$removeEvent(JEvent.SOUND_COMPLETE,onSoundComplete)
			toolsMusic.$removeEvent(JEvent.SOUND_UPDATE,onSoundComplete)
			toolsMusic.$removeEvent(JEvent.SOUND_STOP,onSoundComplete)
			toolsMusic.$removeEvent(JEvent.SOUND_PLAY,onSoundComplete)
		}
		
		private function doPlayEffect(_sprite:Sprite):void
		{
			doStopEffect()
			currentSprite = _sprite
			currentSprite.alpha = 1
			//Tweener.addTween(currentSprite,{alpha:1,time:nDuration,transition:transition,onComplete:onComplete});
		}
		private function onComplete():void
		{
			var _alpha:uint = (currentSprite.alpha==1)?0:1
			Tweener.addTween(currentSprite,{alpha:_alpha,time:nDuration,transition:transition,onComplete:onComplete});
		}
		
		private function doStopEffect():void
		{
			if (currentSprite!=null)
			{
				Tweener.removeTweens(currentSprite)
				currentSprite.alpha = 0
				currentSprite = null
			}
		}
			
		private function doPlay(_index:uint):void
		{
			var currentData:SubGroup_ButtonData
			nPlaying = _index
			currentData = aPlayList[_index]
			toolsMusic.$addEvent(JEvent.SOUND_COMPLETE,onSoundComplete)
			toolsMusic.$addEvent(JEvent.SOUND_UPDATE,onSoundComplete)
			toolsMusic.$addEvent(JEvent.SOUND_STOP,onSoundComplete)
			toolsMusic.$addEvent(JEvent.SOUND_PLAY,onSoundComplete)
			toolsMusic.$play(currentData.file)
			playCases(currentData)
			doPlayEffect(currentData.btn)
		}
		
		
		private function playCases(currentData:SubGroup_ButtonData):void
		{
			switch(playMode)
			{
				case mode_PlayPara:
				case mode_PlayOne:
				case mode_PlayAllFORCE:
					toolsMusic.$playMute(false)
					break
				default:
					if (currentData.force)
					{
						toolsMusic.$playMute(false)
					}else{
						toolsMusic.$playMute(currentData.state)
					}
					break
			}
		}
	}
}


