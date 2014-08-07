package SWFKit {
	public dynamic class Mail extends BaseObj {
		public function Mail(...args) {
			if (args.length == 0) super.fnBaseObjByName("Mail");
			else super.fnBaseObjByID(args[0]);
		}
	}
}