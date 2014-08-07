package JsC.shell
{
	import flash.net.FileReference;
	
	
	public class AsShell extends BaseShellSystem
	{
		public function AsShell()
		{
			
		}
		
		override public function openFile(_url:String):void
		{
			
		}
		
		override public function saveText(_data:String,_file:String,_path:String=""):void
		{
			var file:FileReference = new FileReference();
			file.save(_data,_file)
		}
		
		
		
		
	}
}