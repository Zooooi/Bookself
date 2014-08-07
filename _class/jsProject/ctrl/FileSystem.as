package jsProject.ctrl
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MediaEvent;
	import flash.media.CameraRoll;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import JsC.events.JEvent;
	import JsC.mdel.SystemOS;
	
	
	[Event(name="SELECT", type="JsC.events.JEvent")]
	[Event(name="COMPLETE", type="JsC.events.JEvent")]
	public class FileSystem extends EventDispatcher
	{
		public function FileSystem(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function browser():void
		{
			
			if(SystemOS.isPc){
				pc_brower()
			}else{
				mobile_brower()
			}
		}
		
		private function pc_brower():void
		{
			var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			var docTypes:FileFilter = new FileFilter("Office (*.doc, *.xls, *.ppt)", "*.doc; *.xls; *.ppt;");
			var mp4Types:FileFilter = new FileFilter("Music (*.mp4)", "*.mp4");
			var allTypes:Array = new Array();
			allTypes.push(imageTypes)
			allTypes.push(docTypes)
			allTypes.push(mp4Types)
			var file:FileReference = new FileReference(); 
			file.addEventListener(Event.SELECT, onSelect);
			file.addEventListener(Event.COMPLETE, onSelect);
			file.browse(allTypes) 
		}
		
		private function mobile_brower():void
		{
				/*var _cameraRoll:CameraRoll = new CameraRoll();
				_cameraRoll.addEventListener(MediaEvent.SELECT, onSelectImg);
				_cameraRoll.addEventListener(Event.CANCEL, onCancelSelectImg);
				_cameraRoll.addEventListener(ErrorEvent.ERROR, onSelectError);
				_cameraRoll.addEventListener(Event.COMPLETE, onSavedImg);
				_cameraRoll.browseForImage()*/
		}
		
		protected function onSelect(event:Event):void
		{
			switch(event.type)
			{
				case Event.SELECT:
					dispatchEvent(new JEvent(JEvent.SELECT));
					break;
				case Event.COMPLETE:
					dispatchEvent(new JEvent(JEvent.COMPLETE));
					break;
			}
			
		}
		
		private function onSelectImg(evt:MediaEvent):void {
			trace("select img", evt.data.file);
		
		}
		
		private function onCancelSelectImg(evt:Event):void {
			trace("img canceled");
		}
		
		private function onSelectError(evt:ErrorEvent):void {
			trace("error" + evt.text);
		}
		
		private function onSavedImg(evt:Event):void {
			trace("img saved");
		}
	}
}