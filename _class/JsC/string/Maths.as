package JsC.string
{
	
	/**
	 * ...
	 * @author Jason
	 */
	public class Maths 
	{
		//-------------------------------------------------------------------------------------时间转秒
		public static function TimeSeconds(_S:String):Number
		{
			var aList:Array = _S.split(":")
			var Num:Number=0
			aList.reverse()
			for (var nP:uint = 0; nP < aList.length; nP++ ) {
				Num += Number(aList[nP])*Number(Math.pow(60,nP))
			}
			return Num
		}
		
		public static function TimeCode(nT:Number):Array {
			var aTime:Array=[]
			
			var s1:String=String(int(nT/10%10));
			var s2:String=String(int(nT/100%10));
			aTime[3]=(s2 + s1)
			
			s1=String(int(nT/1000%10));
			s2=String(int(nT/10000%6));
			aTime[2]=(s2 + s1)
			
			s1=String(int(nT/10000/6%10));
			s2=String(int(nT/100000/6%6));
			aTime[1]=(s2 + s1)
			
			s1=String(int(nT/100000/6%10));
			s2=String(int(nT/1000000/6%2));
			aTime[0] = (s2 + s1)
			
			return aTime
		}
		
		public static function Bits(_number:uint, _max:uint=2,_symbol:String="0"):String
		{
			var inNumber:String = String(_number)
			var outNumber:String = inNumber
			for (var nP:uint = 0; nP <(_max - inNumber.length); nP++) outNumber= _symbol + outNumber
			return outNumber
		}
		
		public static function float(_number:Number, _float:uint=1):String
		{
			var i:Number = _float*10
			var n:Number = Math.round(_number*i)/i
			var inNumber:String = String(n);
			return inNumber
		}
		
		
		public static function DataName(_firstName:String="",_lastName:String=""):String
		{
			var _name:String=_firstName
			var _date:Date = new Date
			_name += String(_date.fullYear)
			_name += String(Bits(_date.month + 1,2))
			_name += String(Bits(_date.date , 2))
			_name += String(Bits(_date.hours , 2))
			_name += String(Bits(_date.minutes , 2))
			_name += String(Bits(_date.seconds , 2))
			_name += String(Bits(_date.milliseconds , 3))
			_name += String(Bits(Math.random()*1000 , 4))
			_name += _lastName
			return _name
		}
		
		public static function currentTime():String
		{
			var _name:String = ""
			var _date:Date = new Date
			_name = _date.fullYear+"-"
			_name += Maths.Bits(_date.month + 1 , 2)+"-"
			_name += Maths.Bits(_date.date , 2)+" "
			_name += Maths.Bits(_date.hours , 2)+":"
			_name += Maths.Bits(_date.minutes , 2)+":"
			_name += Maths.Bits(_date.seconds , 2)
			return _name
		}
		
		public static function CurrentTime():String 
		{
			var nowdate:Date = new Date();
			var year:String = String(nowdate.getFullYear())
			var month:String = Maths.Bits(nowdate.getMonth()+1,2);
			var date:String = Maths.Bits(nowdate.getDate(),2);
			var day:String = Maths.Bits(nowdate.getDay(),2);
			var hour:String = Maths.Bits(nowdate.getHours(),2);
			var minute:String = Maths.Bits(nowdate.getMinutes(),2);
			var second:String = Maths.Bits(nowdate.getSeconds(), 2);
			var milliseconds:String = String(Bits(nowdate.milliseconds , 3));
			return (year + "-" +  month + "-" +  date + " " + hour + ":" + minute + ":" + second + "." + milliseconds)
		}
		
		
		
	}
}