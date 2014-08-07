package jsProject.ctrl
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import spark.components.Group;

	public class AppScale
	{
		
		private const cw:uint = 1024;
		private const ch:uint = 768;
		
		public function AppScale(_this:Group)
		{
			return
			var stage:Stage = _this.stage;
			
			var bScale:Boolean
			
			if (Math.max(stage.stageWidth, stage.stageHeight)>cw)
			{
				bScale  = true
				
			}else if (Math.min(stage.stageWidth, stage.stageHeight)>ch){
				bScale  = true
			}
			if (bScale)
			{
				var guiSize:Rectangle = new Rectangle(0, 0, cw, ch);
				var deviceSize:Rectangle = new Rectangle(0, 0,
					Math.max(stage.stageWidth, stage.stageHeight),
					Math.min(stage.stageWidth, stage.stageHeight));
				
				var appScale:Number = 1;
				var appSize:Rectangle = guiSize.clone();
				var appLeftOffset:Number = 0;
				
				
				// if device is wider than GUI's aspect ratio, height determines scale
				if ((deviceSize.width/deviceSize.height) > (guiSize.width/guiSize.height)) {
					appScale = deviceSize.height / guiSize.height;
					appSize.width = deviceSize.width / appScale;
					appLeftOffset = Math.round((appSize.width - guiSize.width) / 2);
					_this.scaleX =appScale
					_this.scaleY =appScale
					_this.width = appSize.width   
				} 
					// if device is taller than GUI's aspect ratio, width determines scale
				else {
					appScale = deviceSize.width / guiSize.width;
					appSize.height = deviceSize.height / appScale;
					appLeftOffset = 0;
					_this.scaleX =appScale
					_this.scaleY =appScale
					_this.height = appSize.height 
				}
				/*this.scaleX =appScale
				this.scaleY =appScale*/
				// scale the entire interface
				
				// crop some menus which are designed to run off the sides of the screen
				_this.scrollRect = appSize;
				//trace(appSize);
			}
		}
	}
}