package jsProject.mdel
{
	
	import components.books.Book;
	import components.books.BookPage;
	import components.symbol.Tools.BookToolsB;
	import components.symbol.Tools.BookToolsT;
	import components.symbol.Tools.ToolMusic;
	import components.symbol.Tools.ToolNavigater;
	import components.symbol.Tools.Tools_BLeft;
	

	public class Viewers
	{
		[Bindable]private static var  book:Book
		[Bindable]private static var  page:BookPage
		[Bindable]private static var  navigater:ToolNavigater
		[Bindable]private static var  music:ToolMusic
		[Bindable]private static var  top:BookToolsT
		[Bindable]private static var  bottom:Tools_BLeft
		
		public static function setBook(_value:Book):void
		{
			book = _value
		}
		
		public static function getBook():Book
		{
			return book
		}
		
		public static function setPage(_value:BookPage):void
		{
			page = _value
		}
		
		public static function getPage():BookPage
		{
			return page
		}
		
		public static function setNavigate(_value:ToolNavigater):void
		{
			navigater = _value
		}
		
		public static function getNavigate():ToolNavigater
		{
			return navigater
		}
		public static function setMusic(_value:ToolMusic):void
		{
			music = _value
		}
		
		public static function getMusic():ToolMusic
		{
			return music
		}
		public static function setTop(_value:BookToolsT):void
		{
			top = _value
		}
		
		public static function getTop():BookToolsT
		{
			return top
		}
		public static function setBottom(_value:Tools_BLeft):void
		{
			bottom = _value
		}
		
		public static function getBottom():Tools_BLeft
		{
			return bottom
		}
		
		public static function closeWin():void
		{
			bottom.$close()
			page.$close()
		}
		
		
		public static function addPageLayer(_uint:int,loader:PageFlipContent):void
		{
			
		}
	}
}