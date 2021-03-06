package jsProject.mdel 
{
	
	public class Files 
	{
		
		private static var bOnce:Boolean
		private static var $path:String=""
		private static var $userPath:String=""
		private static var $docPath:String=""
		private static var $basePath:String=""
			
		public static var $asset:String="assets"	
			
			
		public static function setBasePath(_path:String):void
		{
			$basePath = _path
		}
		
		public static function get path_base():String 
		{
			return $basePath
		}
		
		public static function setAppPath(_path:String):void
		{
			$path = _path
		}
		
		public static function get path_app():String 
		{
			return $path
		}
		
		public static function setDocumentPath(_path:String):void
		{
			$docPath = _path
		}
		
		private static function get path_document():String 
		{
			return $docPath
		}
		
		public static function get path_assets():String 
		{
			return $asset
		}
		
		public static function setUserPath(_path:String):void
		{
			$userPath = _path
		}
		private static function get userFolder():String
		{
			return $userPath
		}
		
		
		
		
			
		//online----------------------------------------------------------------------------------------------------------------
		//书组@固定数据
		public static function get folder_language():String {return  path_base + path_assets + "/language/"}
		public static function get file_language():String {return   "language.xml"}
		
		//书组@固定数据
		public static function get folder_bookself():String {return  path_base + "bookself/"}//return  path_base + path_assets + "/bookself/"
		public static function get file_bookself():String {return   "bookself.xml"}
			
		//书本@用户数据
		[Bindable]public static var book_isbn:String = "isbn";
		private static function getBookPath():String{return book_isbn }
		public static function get folder_books():String {return folder_documentEbook + "books/"}
		public static function get folder_book():String {return folder_books + getBookPath()+"/" }
		public static function get folder_book_Pages():String {return folder_book  + "pages/"}
		public static function get file_book():String {return "data.xml"}
		
		//(book_isbn!="isbn001")? path_base + path_assets + "/books/" + getBookPath() + "/controls/navigate/" : path_base + "controls/navigate/"
		//导航@固定数据
		public static const folder_navigater:String = path_base + "controls/navigate/"
		public static const file_navigater:String = "navigate.xml"
				
			
		//页面组件@用户数据
		public static function get folder_components():String { return folder_book +  "components/"}; // path_base + "controls/components/"	
		public static const file_components:String = NameDefine.KEY_COMPONENTS_KEY + ".xml"
		public static const file_resource:String = NameDefine.KEY_RESOURCE + ".xml"
			
		//用户地址@用户数据	
		public static function get folder_documentEbook():String  {return path_document + "hkep/"  }
		public static function get folder_user():String  {return (folder_documentEbook +"user/")}
		public static function get folder_document():String  {return (folder_user+ userFolder+ "/" +  getBookPath() +"/" )}
		public static function get folder_documentAssets():String {return folder_document + "recorder/"}
		public static function get folder_documentDrawing():String {return folder_document + "drawing/" }
		public static const file_document:String = "usr.xml"
		
		
		
			
		//offline----------------------------------------------------------------------------------------------------------------
		//书组
/*		public static function get folder_language():String {return  path_base + path_assets + "/language/"}
		public static function get file_language():String {return   "language.xml"}
		
		//书组
		public static function get folder_bookself():String {return  path_base + path_assets + "/bookself/"}
		public static function get file_bookself():String {return   "bookself.xml"}
		
		//书本
		[Bindable]public static var book_isbn:String = "isbn001";
		private static function getBookPath():String{return book_isbn}
		public static function get folder_books():String {return path_base + path_assets + "/books/"}
		public static function get folder_book():String {return folder_books + getBookPath() + "/"}
		public static function get folder_book_Pages():String {return path_base + path_assets + "/books/" + getBookPath() + "/pages/"}
		public static function get file_book():String {return "data.xml"}
		
		//导航	
		public static const folder_navigater:String = path_base + "controls/navigate/"
		public static const file_navigater:String = "navigate.xml"
		
		//页面组件	
		public static const folder_components:String = path_base + "controls/components/"
		public static const file_components:String = NameDefine.KEY_COMPONENTS_KEY + ".xml"
		public static const file_resource:String = NameDefine.KEY_RESOURCE + ".xml"
		
		//用户地址	
		public static function get folder_documentEbook():String  {return path_document + "hkep/" }
		public static function get folder_document():String  {return (folder_documentEbook + getBookPath() + "/")}
		public static function get folder_documentAssets():String {return folder_document + "assets/"}
		public static function get folder_documentDrawing():String {return folder_document + "drawing/"}
		public static const file_document:String = "usr.xml"*/
	
			
			
			
			
			
			
		//下载书本@用户数据
		public static function get folder_bookself_download():String {return  folder_documentEbook + "bookself/"}//return  path_base + path_assets + "/bookself/"
		public static function get file_bookself_download():String {return "books.xml"}
		
	}

}