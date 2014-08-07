package JsC.sound{
	public class SoundControl extends SoundBase {
		public function SoundControl(_file:String="",_Obj:Object=undefined) {
			if (_file!="") {
				load(_file,_Obj);
			}
		}
	}
}