package JsC.shell
{
	import flash.events.EventDispatcher;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.XmlContent;
	
	public class BaseShellSystem extends EventDispatcher implements IShellSystem
	{
		public function BaseShellSystem(){}
		/*[Inspectable(enumeration="object,array,xml,flashvars,text,e4x", defaultValue="object", category="General")]*/
		public function traceInfo(_info:String):void
		{
			trace(_info)
		}

		public function setAppPath():void{}
		
		public function saveText(_data:String,_file:String,_path:String=null):void{}
		public function saveData(_data:String,_file:String,_path:String=null):void{}
		
		public function saveXML(_data:String,_file:String,_path:String=null):void{}
		
		public function openFile(_url:String):void{}
		public function deleteFile(_url:String):void{}
		
		public function createFolder(_folder:String):void{}
		
		public function getDocumentPath():String{return ""}
		
		public function runAndMin(_url:String):void{}
		
		public function $dir(_url:String):String
		{
			/*_url = _url.replace(/\//g,"\\")*/
			return _url
		}
		
		protected function getSavePath(_kind:String):String
		{
			return ""
		}
		
		public function browser():String
		{
			return ""
		}
		
		public function copyTo(_s:String,_d:String):void
		{
			
		}
		
		public function copyToUserAssets(_path:String):String
		{
			return ""
		}
		
		
		
		public function saveDrawFile(_xml:XML,_file:String):void
		{
			saveData(_xml,_file,Files.folder_documentDrawing)
		}
		
		public function createUserFolder():void
		{
			createFolder(Files.folder_documentEbook)
			createFolder(Files.folder_user)
			createFolder(Files.folder_document)
			createFolder(Files.folder_documentAssets)
			createFolder(Files.folder_documentDrawing)
			trace(Files.folder_documentEbook)
			trace(Files.folder_user)
			trace(Files.folder_document)
			trace(Files.folder_documentAssets)
			trace(Files.folder_documentDrawing)
		}
		
		public function saveUserFile():void
		{
			saveText(XmlContent.XML_USER,Files.file_document,Files.folder_documentAssets)
		}
		
	}
}