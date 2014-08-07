package JsF.net
{
	import mx.rpc.http.HTTPService;
	
	public class XmlLoader extends HTTPService
	{
		public function XmlLoader(rootURL:String=null, destination:String=null)
		{
			super(rootURL, destination);
			resultFormat = "xml"
		}
	}
}