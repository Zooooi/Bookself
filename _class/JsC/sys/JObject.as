package JsC.sys{
	import flash.utils.ByteArray;

	public class JObject {
		
		//--------------------------------------------------------------------------------(实用类）复制对象
		public static function cloneObject(_Object:Object):Object {
			var bytes:ByteArray=new ByteArray  ;
			bytes.writeObject(_Object);
			bytes.position=0;
			return bytes.readObject();
		}
	}
}