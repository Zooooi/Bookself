package JsA.shell
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import JsC.mdel.SystemOS;
	import JsC.shell.BaseShellSystem;
	
	import jsProject.mdel.Files;
	
	public class AirShell extends BaseShellSystem
	{
		
		override public function openFile(_url:String):void
		{
			var sFullPath:String = $dir( _url)
			var file:File = new File(sFullPath)
			file.openWithDefaultApplication()
		}
		
		override public function saveData(_data:String,_file:String,_path:String=""):void
		{
			var fileStream:FileStream = new FileStream();
			var sFullPath:String = _path + _file;
			fileStream.open(new File(sFullPath), FileMode.WRITE);
			fileStream.writeUTFBytes(_data);
			fileStream.close();
		}
		
		override public function saveText(_data:String,_file:String,_path:String=""):void
		{
			saveData(_data,_file,_path)
		}
		
		override public function setAppPath():void
		{
			Files.setDocumentPath(File.documentsDirectory.url+"/")
			if (SystemOS.isPc)
			{
				Files.setAppPath(File.applicationDirectory.nativePath+"/")
				Files.setBasePath(File.applicationDirectory.nativePath+"/")
			}else{
				Files.setAppPath(File.applicationDirectory.url+"/")
			}
		}
		
		override public function createFolder(_folder:String):void
		{
			new File(_folder)
		}
		override public function browser():String
		{
			/* var imageTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png");
			var docTypes:FileFilter = new FileFilter("Office (*.doc, *.xls, *.ppt)", "*.doc; *.xls; *.ppt;");
			var mp4Types:FileFilter = new FileFilter("Music (*.mp4)", "*.mp4");
			var allTypes:Array = new Array();
			allTypes.push(imageTypes)
			allTypes.push(docTypes)
			allTypes.push(mp4Types)
			var file:FileReference = new FileReference(); 
			file.addEventListener(Event.SELECT, onSelect);
			file.addEventListener(Event.COMPLETE, onSelected);
			file.browse(allTypes) */
			return ""
		}
		
		override public function deleteFile(_url:String):void
		{
			super.deleteFile(_url);
			var file:File = new File(_url)
			file.deleteFile()
			
		}
		
	}
}