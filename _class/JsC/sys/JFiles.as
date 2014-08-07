package JsC.sys{
	

	public class JFiles {
		//--------------------------------------------------------------------------------(实用类）获取当前路径（必要)
		public static function getLocalPath(_this:Object):String {
			var _Path:String;
			var _File:String;
			_File=unescape(_this.loaderInfo.url);
			_Path=_File.slice(0,_File.lastIndexOf("/")+1);
			return _Path;
		}
		//--------------------------------------------------------------------------------(实用类）获取自己的文件名
		public static function getMyName(_this:Object):String {
			var sSWfPath:String 
			var fileArr:Array
			var _MyName:String
			sSWfPath=unescape(_this.loaderInfo.url);
			fileArr = sSWfPath.split("/");
			_MyName = fileArr[fileArr.length - 1]
			if (_MyName.indexOf(".") > 0) {
				_MyName=_MyName.slice(0,_MyName.indexOf("."))
			}
			return _MyName
		}
		public static function getExtName(_fullname:String,_length:uint=5,_useDot:Boolean=false):String
		{
			var _ext:String = _fullname.slice(_fullname.lastIndexOf("."), _fullname.length);
			if (_ext.length > _length) _ext = "";
			return _ext;
		}
		//--------------------------------------------------------------------------------(实用类）转换成Url路径（必要)
		public static function toUrlPath(_Path:String):String {
			var aPath:Array = unescape(_Path).split("\\")
			var _URL:String="file:"
			for (var nP:uint = 0; nP < aPath.length; nP++) {
				if (nP < aPath.length-1) {
					_URL += aPath[nP] + "/"
				}else {
					_URL += aPath[nP]
				}				
			}
			return _URL
		}
		//--------------------------------------------------------------------------------(实用类）随机数组
		public static function randomArray(_Array:Array,_length:uint=0):Array {
			if (! _length || _length>_Array.length) {
				_length=_Array.length;
			}
			var newArr:Array=new Array  ;
			var tempArr:Array=_Array.slice();
			var num:uint;
			while (newArr.length<_length) {
				num=Math.floor(Math.random()*tempArr.length);
				newArr.push(tempArr[num]);
				tempArr.splice(num,1);
			}
			return newArr;
		}
		
	}
}