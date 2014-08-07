package jsProject.view
{
	import components.editors.Editor_Page;

	public class EViewers
	{
		private static var editPage:Editor_Page
		public function EViewers()
		{
		}
		public static function setEditPage(_value:Editor_Page):void
		{
			editPage = _value
		}
		public static function getEditPage():Editor_Page
		{
			return editPage 
		}
	}
}