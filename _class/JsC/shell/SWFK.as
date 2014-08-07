package JsC.shell
{
	
	import SWFKit.Application;
	import SWFKit.Dialogs;
	import SWFKit.File;
	import SWFKit.Folder;
	import SWFKit.Global;
	import SWFKit.Shell;
	import SWFKit.StringStream;
	import SWFKit.application.Appearance;
	
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	
	import jsProject.mdel.Files;
	
	public class SWFK extends BaseShellSystem
	{
		
		override public function setAppPath():void
		{
			ExternalInterface.call("setAppPath");
			var _pathApp:String = new File(".")["path"] + "\\"
			Files.setAppPath(_pathApp)
				
			var _path:String = Object(new Shell).getSpecialFolder("my documents")
			Files.setDocumentPath(_path + "\\")
		}
		
		
		override public function openFile(_url:String):void
		{
			ExternalInterface.call("shellExec", $dir(_url));
		}
		
		override public function saveText(_data:String,_file:String,_path:String=""):void
		{
			ExternalInterface.call("saveTextUTF8", _data , _file ,_path);
		}
		
		override public function saveData(_data:String,_file:String,_path:String=""):void
		{
			ExternalInterface.call("saveText", _data , _file ,_path);
		}
		
		override public function traceInfo(_info:String):void
		{
			ExternalInterface.call("traceInfo",_info);
		}
		
		override public function runAndMin(_url:String):void
		{
			ExternalInterface.call("runAndMin", $dir(_url));
		}
		
		override public function createFolder(_folder:String):void
		{
			ExternalInterface.call("createFolder", $dir(_folder));
		}
		
		override public function copyToUserAssets(_path:String):String
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
		
		override public function browser():String
		{
			var f:String = "All files (*.*)|*.*|" +
				"Images (*.jpg, *.jpeg,*.png)|*.jpg;*.jpeg;*.png|" +
				"Office (*.doc, *.xls, *.ppt)|*.doc; *.xls; *.ppt|" +
				"Music (*.mp4)|*.mp4|" +
				"Zip (*.zip; *.rar)|*.zip; *.rar|" +
				"Text (*.txt)|*.txt|";
			var res:String = Object(new Dialogs).fileOpen(f, "", "", true);
			return res
		}
		
		override public function copyTo(_s:String,_d:String):void
		{
			var file:File = new File(_s);
			Object(file).copy(_d)
		}
		
		override public function $dir(_url:String):String
		{
			_url = _url.replace(/\//g,"\\")
			return _url;
		}
		
		
		
		
		
		
		
	/*	public static function run(_url:String):void
		{
				ExternalInterface.call("run", $dir(_url));
		}
	
		public static function runAndWait(_url:String):void
		{
				ExternalInterface.call("runAndWait", $dir(_url));
		}
		
		public static function openDOC(_url:String):void
		{
				ExternalInterface.call("openDOC", _url);
		}
		
		public static function openXLS(_url:String):void
		{
				ExternalInterface.call("openXLS", _url);
		}
		
		
		public static function openPPT(_url:String):void
		{
				ExternalInterface.call("openPPT", _url);
		}
		
		public static function createFolder(_folder:String):void
		{
				ExternalInterface.call("createFolder",  _folder);
		}
		
		
		public static function quit():void
		{
				ExternalInterface.call("quit");
		}
		
		
		public static function runAndMin(_url:String):void
		{
				_url = _url.replace(/\//g,"\\")
				ExternalInterface.call("runAndMin", _url);
		}*/
		
	}
}