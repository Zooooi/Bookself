package jsProject.mdel 
{
	/**
	 * ...
	 * @author ...
	 */
	
	public class Language 
	{
		//------------------------------------------------------------const
		public static const CN:String = "CN"
		public static const EN:String = "EN"
		
		protected static const CFACE:String = "DFKaiShuW3-B5"
		protected static const CFONT:String = "華康楷書體W3"
		protected static const CTITLE:String = "華康楷書體W3"
		protected static const EFACE:String = "Verdana"
		protected static const EFONT:String = "Verdana"
		protected static const ETITLE:String = "Verdana"
		
		
		public static var font:String
		public static var face:String
		public static var title:String
		public static var runtime:String
		public static var language:String
		public static var size:uint
		
		//------------------------------------------------------------mdm Data
		
		public static function setLanguage():void
		{
			switch (language) 
			{
				case CN:
					face = CFACE
					font = CFONT
					title = CFONT
					size = 16
					break;
					
				case EN:
					face = EFACE
					font = EFONT
					title = EFONT
					size = 12
					break;
			}
			runtime = language
		}
	}

}