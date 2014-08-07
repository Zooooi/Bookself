package jsProject.ctrl 
{

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class BookStage 
	{
		
		public function BookStage() 
		{
			
		}
		public static function init(_stage:Stage):void
		{
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align = StageAlign.TOP_LEFT;
		}
		
	}

}