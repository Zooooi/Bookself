package jsProject.mdel
{
	public class DrawData
	{
		
		[Bindable]public static var currentStrokeMax:uint
		[Bindable]public static var currentStrokeMin:uint
		[Bindable]public static var currentFillColor:uint
		[Bindable]public static var currentFillAlpha:Number
		[Bindable]public static var currentStrokeColor:uint
		[Bindable]public static var currentStrokeAlpha:Number
		[Bindable]public static var currentStroke:uint
		
		
		private static const aColor:Vector.<uint>=Vector.<uint>([
			0xFF98CD,0xFFCC98,0xFFFF98,0xCCFFCC,0xCCFFFF,0x98CCFF,0xCC98FF,0xFFFFFF,
			0xFB00FB,0xFFCC00,0xFFFF00,0x00FF00,0x00FFFF,0x00CCFF,0x963063,0xBFBFBF,
			0xFF0000,0xFF9600,0x96CA00,0x329865,0x32CCCC,0x3063FD,0x7F007F,0x989898,
			0x7F0000,0xFF6500,0x7F7F00,0x007D00,0x007F7F,0x0000FF,0x656598,0x7D7D7D,
			0x000000,0x963000,0x323200,0x003200,0x003265,0x00007F,0x323298,0x323232
		])
			
		// pen....................................................................................................................
		private static const penStrokeMax:uint = 80
		private static const penStrokeMin:uint = 1
		private static const penStrokeColorDefault:uint = 1
			
		private static var penFillColor:uint = 0xFFFFFF
		private static var penFillAlpha:Number = 0.4
		private static var penStrokeColor:uint = 0x000000
		private static var penStrokeAlpha:Number = 1
		private static var penStroke:uint = 1
			
		// nite....................................................................................................................
		private static const niteStrokeMax:uint = 80
		private static const niteStrokeMin:uint = 1
		private static const niteStrokeColorDefault:uint = 0.2	
			
		private static var niteFillColor:uint = 0xFF0000
		private static var niteFillAlpha:Number = 0.2
		private static var niteStrokeColor:uint = 0xFFFF00
		private static var niteStrokeAlpha:Number = 0.5
		private static var niteStroke:uint = 4
		
		//....................................................................................................................	
		protected static const modePen:String = "modePen"
		protected static const modeNite:String = "modeNite"
		protected static const modeLayer:String = "modeLayer"
		protected static const modeEarse:String = "modeEarse"
		protected static const modeEarseAll:String = "modeEarseAll"
		protected static const modeMove:String = "modeMove"
		protected static var mode:String = modePen
		
		//....................................................................................................................	
		protected static var nLayer:uint = 0
			
		//....................................................................................................................	
		protected static var nShapeKind:uint = 0	
			
			
		// mode =======================================================================================================================
		
		public static function setMode_Pen():void {mode = modePen;updateData()}
		
		public static function setMode_Nite():void {mode = modeNite;updateData()}
		
		public static function setMode_Layer():void {mode = modeLayer}
		
		public static function setMode_Earse():void {mode = modeEarse}
		
		public static function setMode_EarseAll():void {mode = modeEarseAll}
		
		public static function setMode_Move():void {mode = modeMove}
		
		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		// property =======================================================================================================================
		public static function setShape(_value:uint):void
		{
			nShapeKind = _value
		}
		
		public static function setStrokeColor(_value:uint):void
		{
			switch(mode)
			{
				case modePen: penStrokeColor = aColor[_value];break;
				case modeNite: niteStrokeColor = aColor[_value];break;
			}
			updateData()
		}
		
		
		public static function setStroke(_value:uint):void
		{
			switch(mode)
			{
				case modePen: penStroke = _value;break;
				case modeNite: niteStroke = _value;break;
			}
			updateData()
		}
		
		
		public static function setStrokeAlpha(_value:Number):void
		{
			switch(mode)
			{
				case modePen: penStrokeAlpha = _value;break;
				case modeNite: niteStrokeAlpha = _value;break;
			}
			updateData()
		}
		
		public static function setFillColor(_value:Number):void
		{
			switch(mode)
			{
				case modePen: penFillColor = aColor[_value];break;
				case modeNite: niteFillColor = aColor[_value];break;
			}
			updateData()
		}
		
		public static function setFillAlpha(_value:Number):void
		{
			switch(mode)
			{
				case modePen: penFillAlpha = _value;break;
				case modeNite: niteFillAlpha = _value;break;
			}
			updateData()
		}
		public static function  getColorIndex(_value:uint):uint
		{
			return aColor.indexOf(_value)
		}
		public static function  getShapeIndex():uint
		{
			return nShapeKind
		}
		
		// --------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
		
		private static function updateData():void
		{
			switch(mode)
			{
				case modePen: 
					currentFillColor = penFillColor
					currentFillAlpha = penFillAlpha
					currentStrokeColor = penStrokeColor
					currentStrokeAlpha = penStrokeAlpha
					currentStroke = penStroke * Math.round(penStrokeMax / 7)
					currentStrokeMax = penStrokeMax
					currentStrokeMin = penStrokeMin
					break;
				
				case modeNite:
					currentFillColor = niteFillColor
					currentFillAlpha = niteFillAlpha
					currentStrokeColor = niteStrokeColor
					currentStrokeAlpha = niteStrokeAlpha
					currentStroke = niteStroke * Math.round(niteStrokeMax / 7)
					currentStrokeMax = niteStrokeMax
					currentStrokeMin = niteStrokeMin
					break;
			}
		}
		
	}
}