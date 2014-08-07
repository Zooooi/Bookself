package jsProject.ctrl
{
	import JsC.mdel.SystemOS;
	import JsC.shell.ShellSystem;
	import JsC.string.Escape;
	
	import components.symbol.Tools.ToolMusic;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import jsProject.events.ComponentEvent;
	import jsProject.mdel.Files;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.Viewers;
	
	import mx.core.IVisualElement;
	
	public class OpenComponentFiles
	{
		private var sPath:String
		private var sCurrentPath:String
		private var sFile:String
		private var sUrl:String
		private var sOpenFile:String
		private var bHasFolder:Boolean
		private var main:IVisualElement
		private var xml:XML
		
		[Bindable]public var $path:String = Files.folder_book
		
		public function OpenComponentFiles(_xml:XML,_path:String="")
		{
			if (_path!="")$path = _path
			xml = _xml
			sOpenFile = xml.@openfile
			if (sOpenFile == "") return
			main = Viewers.getBook()
			switch(String(xml.@action))
			{
				case NameDefine.COM_OPEN_HTML:onOpenHtml();break;
				case NameDefine.COM_OPEN_APP:;break;
				case NameDefine.COM_OPEN_DOC:onOpenFile();break;
				case NameDefine.COM_OPEN_DOC:onOpenFile();break;
				case NameDefine.COM_OPEN_XLS:onOpenFile();break;
				case NameDefine.COM_OPEN_PPT:onOpenFile();break;
				case NameDefine.COM_OPEN_PDF:onOpenFile();break;
				case NameDefine.COM_SHOW_PIC:onOpenFile();break;
				case NameDefine.COM_OPEN_FILE:onOpenFile();break;
				case NameDefine.COM_PLAY_MOV:onOpenMov();break;
				case NameDefine.COM_PLAY_SND:onOpenMP3();break;
			}
		}
		private function setPath():void
		{
			var _folder:String = xml.@folder
			var _split:Number = sOpenFile.lastIndexOf("/")
			if (_split<0)
			{
				//独立文件
				bHasFolder = false
				sOpenFile = xml.@openfile
				sCurrentPath = sOpenFile
				sFile  = xml.@openfile
			}else{
				//有文件夹
				bHasFolder = true
				sOpenFile = xml.@openfile
				sCurrentPath = sOpenFile.slice(0,_split+1)
				sFile  = sOpenFile.slice(_split+1,sOpenFile.length)
			}
			sPath = $path + _folder + "/" + sCurrentPath
			sUrl = $path + _folder + "/" + sOpenFile
		}
		
		protected function onOpenHtml():void
		{
			var _event:ComponentEvent
			setPath()
			switch(SystemOS.mode)
			{
				case SystemOS.MOBILE:
					_event = new ComponentEvent(ComponentEvent.OPEN_HTML)
					if (Escape.isURL(sOpenFile))
					{
						_event._url = sOpenFile
					}else{
						_event._path = sPath
						_event._file = sFile
						_event._url = sUrl
						_event._hasFolder = bHasFolder
					}
					main.dispatchEvent(_event)
					break;
				
				case SystemOS.PC:
					
					if (sOpenFile.indexOf("http://")==0 || sOpenFile.indexOf("www.")==0)
					{
						navigateToURL(new URLRequest(sOpenFile))
					}else{
						ShellSystem.current.openFile(sUrl)
					}
					break
			}
		}
		
		
		protected function onOpenMP3(event:MouseEvent=null):void
		{
			var music:ToolMusic = Viewers.getMusic()
			setPath()
			music.$play(sUrl)
		}
		
		protected function onOpenFile(event:MouseEvent=null):void
		{
			var _event:ComponentEvent
			setPath()
			switch(SystemOS.mode)
			{
				case SystemOS.MOBILE:
					_event = new ComponentEvent(ComponentEvent.OPEN_OFFICE)
					_event._path = sPath
					_event._file = sFile
					_event._url = sUrl
					_event._hasFolder = bHasFolder
					main.dispatchEvent(_event)
					break;
				
				case SystemOS.PC:
					ShellSystem.current.openFile(sUrl)
					/*switch(String(xml.@action))
					{
					case NameDefine.COM_OPEN_DOC:
					SWFK.openDOC(sUrl)
					break;
					case NameDefine.COM_OPEN_XLS:
					SWFK.openXLS(sUrl)
					break;
					case NameDefine.COM_OPEN_PPT:
					SWFK.openPPT(sUrl)
					break;
					default:
					
					break
					}*/
					
					break
			}
		}	
		
		protected function onOpenMov(event:MouseEvent=null):void
		{
			var _event:ComponentEvent
			setPath()
			switch(SystemOS.mode)
			{
				case SystemOS.MOBILE:
					_event = new ComponentEvent(ComponentEvent.OPEN_MOVIE)
					_event._path = sPath
					_event._file = sFile
					_event._url = sUrl
					_event._hasFolder = bHasFolder
					main.dispatchEvent(_event)
					break;
				case SystemOS.PC:
					sUrl = sUrl.replace(/\//g,"\\")
					ShellSystem.current.openFile(sUrl)
					break
			}
		}
	}
}