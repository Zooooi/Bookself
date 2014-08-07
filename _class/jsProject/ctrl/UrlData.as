package jsProject.ctrl
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import JsC.events.JEvent;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.UserInfo;
	
	
	[Event(name="YES", type="JsC.events.JEvent")]
	[Event(name="NO", type="JsC.events.JEvent")]
	[Event(name="IOERROR", type="JsC.events.JEvent")]
	
	public class UrlData extends EventDispatcher
	{
		/**
		 * 1) jasonli.leadcoinc.com
		 *    getfile1_1.php 
		 * 2) www.zooooi.com
		 *    getfile1.php
		 * 3) 192.168.0.13
		 *    getfile1_1.php
		 */		
		protected const webSite:String = "http://jasonli.leadcoinc.com/bookself/";//www.zooooi.com//http://jasonli.leadcoinc.com/bookself/ //192.168.0.13
		protected const webPath:String = "site/admin/";
		protected const pageCheckuser:String = "checkuser.php";
		protected const pageBookself:String = "getbookselft.php";
		protected const pageDownInfo:String = "downloadinfo.php";
		protected const pageGetFile:String = "getfile.php";
		
		private var myLoader:URLLoader;
		private var myFunc:Function;
		public var $xml:XML
		
		public function UrlData() 
		{
			myFunc = new Function
				
			myLoader = new URLLoader
			myLoader.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void
			{
				dispatchEvent(new JEvent(JEvent.IOERROR));
			});
			myLoader.addEventListener(Event.COMPLETE,function(event:Event):void
			{
				
				var _id:String
				try
				{
					$xml = new XML(event.currentTarget.data);
					_id = $xml.action.@id;
					trace($xml)
				} 
				catch(error:Error) 
				{
					trace(event.currentTarget.data);
					_id = "false";
					dispatchEvent(new JEvent(JEvent.IOERROR));
				}
				switch(_id)
				{
					case "false":
					case "none":
						dispatchEvent(new JEvent(JEvent.NO));
						break
					case "success":
						dispatchEvent(new JEvent(JEvent.YES));
						break
					default:
						myFunc(_id);
				}
				
			});
		}
		
		public function login(data:Object=null):void
		{
			if (data==null) data = new Object
			data.username = UserInfo.name;
			data.password = UserInfo.pass;
			onLoad(pageCheckuser,data)
			
			myFunc = function(_id:String):void{
				switch(_id)
				{
					case "login":
						UserInfo.id = $xml.action.@uid;
						Files.setUserPath($xml.action.@folder)
						dispatchEvent(new JEvent(JEvent.YES));
						break
				}
			}
				
			
		}
		
		public function getBookSelf():void
		{
			var data:Object = new Object;
			data.uid = UserInfo.id;	
			onLoad(pageBookself,data);
		}
		
		
		public function sendDownLoadInfo(data:Object = null):void
		{
			onLoad(pageDownInfo,data);
		}
		
		public function getZipFile(_id:String):URLRequest
		{
			var data:Object = new Object;
			data.bookid = _id;
			return postWebData(pageGetFile,data);
		}
		
		
		protected function getXML():XML
		{
			return $xml;
		}
		
		protected function postWebData(_page:String,data:Object):URLRequest
		{
			var _link:String = webSite + webPath + _page;
			var _urlLink:URLRequest = new URLRequest(_link);	
			var variables:URLVariables = new URLVariables();
			for (var s:String in data) variables[s] = data[s];
			_urlLink.data = variables;
			_urlLink.method = URLRequestMethod.POST
			return _urlLink;
		}
		
		protected function onLoad(_page:String,data:Object):void
		{
			myLoader.load(postWebData(_page,data));
		}
		
		public function stop():void
		{
			myLoader.close()
		}
	}
	
}