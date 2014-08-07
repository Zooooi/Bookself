package jsProject.ctrl
{
	import JsC.mdel.SystemOS;
	
	import flash.display.Stage;

	public class StageCtrl
	{
		
		public static function resize(_stage:Stage,_system:Boolean):Boolean
		{
			var _lan:Boolean
		
			var _bCompare:Boolean = _stage.stageWidth>_stage.stageHeight
			if (SystemOS.isMobile)
			{
				if (_system)
				{
					_lan = _bCompare
				}else
				{
					//android
					_lan = !_bCompare
				}
			}else{
				_lan = true
			}
			return _bCompare//_lan
		}
	}
}