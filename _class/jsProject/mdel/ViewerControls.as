package jsProject.mdel
{
	import components.books.BookPage;
	
	import jsProject.view.BaseUIButton;
	import jsProject.view.UIResourceButton;
	
	
	

	public class ViewerControls
	{
		private static var aResourceButton:Vector.<BaseUIButton>
		
		public static function init():void
		{
			aResourceButton = new Vector.<BaseUIButton>
		}
		
		
		public static function addResourceButton(_button:BaseUIButton):void
		{
			aResourceButton.push(_button)
		}
		
		public static function delResourceButton(_xmlList:XMLList):void
		{
			for (var i:int = 0; i < aResourceButton.length; i++) 
			{
				if (aResourceButton[i].$compareAndDestroy(_xmlList))
				{
					aResourceButton.splice(i,1)
					break
				}
			}
			
		}
	}
}