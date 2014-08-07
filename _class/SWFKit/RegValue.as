package SWFKit {
	public dynamic class RegValue extends BaseObj {
		public function RegValue(...args) {
			if (args.length == 0) super.fnBaseObjByName("RegValue");
			else super.fnBaseObjByID(args[0]);
		}
	}
}