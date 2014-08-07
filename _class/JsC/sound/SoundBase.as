package JsC.sound {
	import JsC.events.JEvent;
	import JsC.loader.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;

	
	[Event(name="COMPLETE", type="JsC.events.JEvent")]
	public class SoundBase extends EventDispatcher {
		

		public var channel:SoundChannel;
		public var position:Number=0;
		public var time:Number=1;
		public var autoPlay:Boolean=true;
		public var sound:Sound;

		private var timer:Timer=new Timer(10);
		private var nVolume:Number=0.5;
		private var ActionObject:Object;
		private var bPlayOrder:Boolean
		private var SoundFile:String
		
		public function load(_file:String, _Obj:Object = null):void {
			SoundFile=_file
			if (_Obj!=null) {
				if (_Obj.complete!=undefined) {
					addEventListener(JEvent.COMPLETE,_Obj.complete)
				}
			}else {
				_Obj = new Object
			}
			_Obj.complete = LoadSoundComplete;
			ActionObject=new Object();
			for (var _S:String in _Obj) {
				ActionObject[_S]=_Obj[_S];
			}
			var LoadSound:GetLoader=new GetLoader(_file,ActionObject);
		}
		public function play(_file:String = "", _Obj:Object = undefined):void {
			if (_file != "") {
				sound = null
				channel=null
				load(_file,_Obj);
			} else {
				autoPlay = true
				if (sound != null) {
					stop();
					channel = sound.play(position, time);
					var transform:SoundTransform=channel.soundTransform;
					transform.volume=nVolume;
					channel.soundTransform = transform;

				}else {
					load(SoundFile,ActionObject);
				}
			}
		}
		public function stop():void {
			if (channel!=null) {
				channel.stop();
				timer.stop();
			}
		}
		public function resume():void {
			if (sound!=null) {
				stop();
				channel=sound.play(channel.position);
				timer.start();
			}
		}
		public function seek(_position:Number,_time:Number):void {
			if (sound!=null) {
				stop();
				timer.start();
				channel=sound.play(_position,_time);

			}
		}
		public function get volume():Number {
			var transform:SoundTransform=channel.soundTransform;
			return transform.volume;
		}
		public function set volume(_vol:Number):void {
			nVolume=Math.abs(_vol);
			if (channel!=null) {
				var transform:SoundTransform=channel.soundTransform;
				transform.volume=_vol;
				channel.soundTransform=transform;
			}
		}
		public function addEvent(_Act:Object = null):void {
			setEvent(_Act,true);
		}
		public function removeEvent(_Act:Object = null):void {
			setEvent(_Act,false);
		}
		private function setEvent(_Act:Object = null,bAdd:Boolean=true):void {
			var sEvent:String
			if (bAdd) {
				sEvent="addEventListener"
			}else{
				sEvent="removeEventListener"
			}
			var sP:String;
			
			if (_Act==null) {
				_Act = ActionObject;
				for (sP in ActionObject) {
					if (channel.hasEventListener(_Act[sP])) {
						channel[sEvent](sP,_Act[sP]);
					}
					if (timer.hasEventListener(_Act[sP])) {
						timer[sEvent](sP,_Act[sP]);
					}
					if (sound.hasEventListener(_Act[sP])) {
						sound[sEvent](sP,_Act[sP]);
					}
				}
			} else {
				for (sP in _Act) {
					var _bPass:Boolean = true;
					switch (sP) {
						case "soundComplete" :
						case Event.SOUND_COMPLETE :
							channel[sEvent](sP, _Act[sP]);
							break;
						case "timer" :
						case TimerEvent.TIMER :
							timer[sEvent](sP, _Act[sP]);
							_bPass=false;
							break;
						case "Playing" :
						case ProgressEvent.PROGRESS :
							sound[sEvent](sP, _Act[sP]);
							break;
						default :
							_bPass=false;
					}

				}
			}
		}
		private function LoadSoundComplete(event:Event):void {
			sound = Sound(event.target);	
			if (autoPlay || bPlayOrder) {
				bPlayOrder=false
				play();
			}else {
				channel = sound.play()
				channel.stop()
			}
			setEvent(ActionObject)
			dispatchEvent(new JEvent(JEvent.COMPLETE))
		}

	}
}