package jsProject.ctrl
{
	import JsC.shell.ShellSystem;
	import JsC.string.Maths;
	
	import SWFKit.File;
	import SWFKit.Folder;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.XmlContent;
	
	public class FileCtrl extends ShellSystem
	{
		public function FileCtrl()
		{
			super();
		}
		
		
		public static function saveUserFile():void
		{
			traceInfo("flash "+ Files.folder_document+" "+Files.file_document)
			saveText(XmlContent.XML_USER,Files.file_document,Files.folder_documentAssets)
		}
		
		public static function copyToUserAssets(_path:String):String
		{
			var _url:String = _path.replace(/\//g,"\\")
			var _arr:Array = _url.split("\\")
			var _name:String = _arr[_arr.length-1]
			_url = Files.folder_documentAssets.replace(/\//g,"\\")
			new Folder(_url);
			traceInfo("flash "+ _url)
			traceInfo("flash "+ _path+" "+Files.folder_documentAssets + _name)
			copyTo(_path,Files.folder_documentAssets + _name)
			return _name
		}
		
	}
}