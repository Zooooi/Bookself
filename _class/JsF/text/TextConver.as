package JsF.text
{
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;

	public class TextConver
	{
		public function TextConver()
		{
			
		}
		
		public static function textFlowToString(_textFlow:TextFlow):String
		{
			return String(TextConverter.export(_textFlow,TextConverter.TEXT_LAYOUT_FORMAT,ConversionType.STRING_TYPE))
		}
		
		public static function stringToTextFlow(_text:String):TextFlow
		{
			return TextConverter.importToFlow(_text,TextConverter.TEXT_LAYOUT_FORMAT)
		}
	}
}