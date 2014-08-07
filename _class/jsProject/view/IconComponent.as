package jsProject.view
{
	import JsC.mdel.SystemOS;
	import JsC.shell.ShellSystem;
	
	import components.symbol.Tools.ToolMusic;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import jsProject.events.ComponentEvent;
	import jsProject.mdel.Files;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.Viewers;
	
	import spark.components.Group;

	public class IconComponent extends IconButtonSprite
	{
		private var sPath:String
		private var sCurrentPath:String
		private var sFile:String
		private var sUrl:String
		private var sOpenFile:String
		private var bHasFolder:Boolean
		
		private var main:Group
		
		
		public function IconComponent()
		{
			super();
		}
		override public function $setData(_path:String,_xml:String):void
		{
			super.$setData(_path,_xml)
			sOpenFile = xml.@openfile
			if (sOpenFile == "") return
			main = Viewers.getBook()
			switch(String(xml.@action))
			{
				case NameDefine.COM_OPEN_HTML:btn.addEventListener(MouseEvent.CLICK,onOpenHtml);break;
				case NameDefine.COM_OPEN_APP:;break;
				case NameDefine.COM_OPEN_DOC:btn.addEventListener(MouseEvent.CLICK,onOpenFile);break;
				case NameDefine.COM_OPEN_DOC:btn.addEventListener(MouseEvent.CLICK,onOpenFile);break;
				case NameDefine.COM_OPEN_XLS:btn.addEventListener(MouseEvent.CLICK,onOpenFile);break;
				case NameDefine.COM_OPEN_PPT:btn.addEventListener(MouseEvent.CLICK,onOpenFile);break;
				case NameDefine.COM_OPEN_PDF:btn.addEventListener(MouseEvent.CLICK,onOpenFile);break;
				case NameDefine.COM_SHOW_PIC:btn.addEventListener(MouseEvent.CLICK,onOpenFile);break;
				case NameDefine.COM_PLAY_MOV:btn.addEventListener(MouseEvent.CLICK,onOpenMov);break;
				case NameDefine.COM_PLAY_SND:btn.addEventListener(MouseEvent.CLICK,onOpenMP3);break;
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
			sPath = Files.folder_book + _folder + "/" + sCurrentPath
			sUrl = Files.folder_book + _folder + "/" + sOpenFile
		}
		
		protected function onOpenHtml(event:Event):void
		{
			var _event:ComponentEvent
			setPath()
			switch(SystemOS.mode)
			{
				case SystemOS.MOBILE:
					_event = new ComponentEvent(ComponentEvent.OPEN_HTML)
					if (sOpenFile.indexOf("http://")>=0)
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
					if (sOpenFile.indexOf("http://")==0)
					{
						navigateToURL(new URLRequest(sOpenFile))
					}else{
						ShellSystem.current.openFile(sUrl)
					}
					break
			}
		}
		
		
		protected function onOpenMP3(event:MouseEvent):void
		{
			var music:ToolMusic = Viewers.getMusic()
			setPath()
			music.$play(sUrl)
		}
		
		protected function onOpenFile(event:MouseEvent):void
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
		
		protected function onOpenMov(event:MouseEvent):void
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
					sUrl = sUrl.replace(/\//g,"\\");
					ShellSystem.current.openFile(sUrl)
					break
			}
		}
	}
}

