package jsProject.ctrl
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import jsProject.events.PageFilpEvents;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.PageFlipContent;
	import JsC.mdel.SystemOS;
	
	[Event(name = "onLoadInit", type = "Project.events.PageFilpEvents")]
	[Event(name = "onLoading", type = "Project.events.PageFilpEvents")]
	[Event(name = "onLoadEnd", type = "Project.events.PageFilpEvents")]
	[Event(name = "onPageEnd", type = "Project.events.PageFilpEvents")]
	[Event(name = "onPagePlaying", type = "Project.events.PageFilpEvents")]
	[Event(name = "onResetLoc", type = "Project.events.PageFilpEvents")]
	
	public class PageFlipClass extends EventDispatcher
	{
		private const sLoad:String = "sLoad_"
		private const sType:String = ""
		
		private const sTimeFlagStop:String = "stop"
		private const sTimeFlag_StartPlay:String = "startplay"
		private const sTimeFlag_AutoPlay:String = "autoplay"
		private const cLoader:String = "loader"
			
		private const sPageNode:String = NameDefine.KEY_PAGES
		
		public var book_page:uint = 0;//当前页
		public var book_totalpage:uint;//总页数
		private var book_path:String
		
		//可设置或可调用接口,页数以单页数计算~---------------------------------------
		private var myXML:XML;
		private var book_root:Sprite;//装载book的MC
		private var book_initpage:uint;//初始化到第N页
		
		private var book_TimerNum:uint=20;//Timer的间隔时间
		
		
		private var nMaskW:uint
		private var nMaskH:uint
		
		private var nLoadPage:uint
		private var aLoadPage:Vector.<Loader>
		
		private var currentPageLoader:PageFlipContent

		//END!!--------------------------------------------------------------------

		private var book_x:uint;
		private var book_y:uint;
		private var book_width:Number;
		private var book_height:Number;
		private var book_topage:Number;

		private var book_CrossGap:Number;
		private var bookArray_layer1:Array;
		private var bookArray_layer2:Array;

		private var book_TimerFlag:String = sTimeFlagStop;
		public function get $TimerFlag():String{return book_TimerFlag}
		private var book_TimerArg0:Number=0;
		private var book_TimerArg1:Number=0;
		private var u:Number;
		private var book_px:Number=0;
		private var book_py:Number=0;
		private var book_toposArray:Array;
		private var book_myposArray:Array;
		private var book_timer:Timer;

		private var Bmp0:BitmapData;
		private var Bmp1:BitmapData;
		private var bgBmp0:BitmapData;
		private var bgBmp1:BitmapData;

		private var pageMC:Sprite=new Sprite();
		private var bgMC:Sprite=new Sprite();

		private var render0:Shape=new Shape();
		private var render1:Shape=new Shape();
		private var shadow0:Shape=new Shape();
		private var shadow1:Shape=new Shape();

		private var Mask0:Shape=new Shape();
		private var Mask1:Shape=new Shape();

		private var p1:Point;
		private var p2:Point;
		private var p3:Point;
		private var p4:Point;

		private var limit_point1:Point;
		private var limit_point2:Point;
		private var pageMode:uint
		
		private var nodePage:XMLList
		private var aDisplayPage:Vector.<PageFlipContent>
		
		
		
		
		//**init Parts------------------------------------------------------------------------
		private function setValue(_x:uint, _y:uint, _w:uint,_h:uint ):void
		{
			book_x = _x 
			book_y = _y 
			
			book_width = _w / 2
			book_height = _h ;
			
			pageMC.x = book_x
			pageMC.y = book_y
				
			
			p1 = new Point(book_x, book_y);
			p2 = new Point(book_x, book_y + book_height);
			p3 = new Point(book_x + _w, book_y);
			p4 = new Point(book_x + _w, book_y + book_height);
			
			limit_point1 = new Point(book_x + book_width, book_y);
			limit_point2 = new Point(book_x + book_width, book_y + book_height);
			
			book_toposArray = [p3, p4, p1, p2];
			book_myposArray = [p1, p2, p3, p4];
			
			book_CrossGap = Math.sqrt(book_width * book_width + book_height * book_height);
		}
		
		
		
		
		//End init------------------------------------------------------------------------

		
		
		
		
		//**DrawPage Parts------------------------------------------------------------------------
		private function DrawPage(num:Number,_movePoint:Point,bmp1:BitmapData,bmp2:BitmapData):void {

			//var _movePoint:Point=new Point(mouseX,mouseY);
			var _actionPoint:Point;

			var book_array:Array;
			var book_Matrix1:Matrix=new Matrix();
			var book_Matrix2:Matrix=new Matrix();
			var Matrix_angle:Number;

			if (num==1) {

				_movePoint=CheckLimit(_movePoint,limit_point1,book_width);
				_movePoint=CheckLimit(_movePoint,limit_point2,book_CrossGap);

				book_array=GetBook_array(_movePoint,p1,p2);
				_actionPoint=book_array[1];
				GetLayer_array(_movePoint,_actionPoint,p1,p2,limit_point1,limit_point2);

				DrawShadowShap(shadow0, Mask0, book_width * 1.5, book_height * 4, p1, _movePoint, new Array(p1, p3, p4, p2), 0.5);
				DrawShadowShap(shadow1, Mask1, book_width * 1.5, book_height * 4, p1, _movePoint, bookArray_layer1, 0.45);

				Matrix_angle=angle(_movePoint,_actionPoint)+90;
				book_Matrix1.rotate((Matrix_angle/180)*Math.PI);
				book_Matrix1.tx=book_array[3].x;
				book_Matrix1.ty=book_array[3].y;

				book_Matrix2.tx=p1.x;
				book_Matrix2.ty=p1.y;

			} else if (num==2) {

				_movePoint=CheckLimit(_movePoint,limit_point2,book_width);
				_movePoint=CheckLimit(_movePoint,limit_point1,book_CrossGap);

				book_array=GetBook_array(_movePoint,p2,p1);
				_actionPoint=book_array[1];
				GetLayer_array(_movePoint,_actionPoint,p2,p1,limit_point2,limit_point1);

				DrawShadowShap(shadow0,Mask0,book_width*1.5,book_height*4,p2,_movePoint,new Array(p1,p3,p4,p2),0.5);
				DrawShadowShap(shadow1,Mask1,book_width*1.5,book_height*4,p2,_movePoint,bookArray_layer1,0.45);

				Matrix_angle=angle(_movePoint,_actionPoint)-90;
				book_Matrix1.rotate((Matrix_angle/180)*Math.PI);
				book_Matrix1.tx=book_array[2].x;
				book_Matrix1.ty=book_array[2].y;

				book_Matrix2.tx=p1.x;
				book_Matrix2.ty=p1.y;

			} else if (num==3) {

				_movePoint=CheckLimit(_movePoint,limit_point1,book_width);
				_movePoint=CheckLimit(_movePoint,limit_point2,book_CrossGap);

				book_array=GetBook_array(_movePoint,p3,p4);
				_actionPoint=book_array[1];
				GetLayer_array(_movePoint,_actionPoint,p3,p4,limit_point1,limit_point2);

				DrawShadowShap(shadow0,Mask0,book_width*1.5,book_height*4,p3,_movePoint,new Array(p1,p3,p4,p2),0.5);
				DrawShadowShap(shadow1,Mask1,book_width*1.5,book_height*4,p3,_movePoint,bookArray_layer1,0.4);

				Matrix_angle=angle(_movePoint,_actionPoint)+90;
				book_Matrix1.rotate((Matrix_angle/180)*Math.PI);
				book_Matrix1.tx=_movePoint.x;
				book_Matrix1.ty=_movePoint.y;

				book_Matrix2.tx=limit_point1.x;
				book_Matrix2.ty=limit_point1.y;

			} else {

				_movePoint=CheckLimit(_movePoint,limit_point2,book_width);
				_movePoint=CheckLimit(_movePoint,limit_point1,book_CrossGap);

				book_array=GetBook_array(_movePoint,p4,p3);
				_actionPoint=book_array[1];
				GetLayer_array(_movePoint,_actionPoint,p4,p3,limit_point2,limit_point1);

				DrawShadowShap(shadow0,Mask0,book_width*1.5,book_height*4,p4,_movePoint,new Array(p1,p3,p4,p2),0.5);
				DrawShadowShap(shadow1,Mask1,book_width*1.5,book_height*4,p4,_movePoint,bookArray_layer1,0.4);

				Matrix_angle=angle(_movePoint,_actionPoint)-90;
				book_Matrix1.rotate((Matrix_angle/180)*Math.PI);
				book_Matrix1.tx=_actionPoint.x;
				book_Matrix1.ty=_actionPoint.y;

				book_Matrix2.tx=limit_point1.x;
				book_Matrix2.ty=limit_point1.y;
			}
			
			DrawShape(render1,bookArray_layer1,bmp1,book_Matrix1);
			DrawShape(render0,bookArray_layer2,bmp2,book_Matrix2);
		}
		
		private function CheckLimit($point:Point,$limitPoint:Point,$limitGap:Number):Point {

			var $Gap:Number=Math.abs(pos($limitPoint,$point));
			var $Angle:Number=angle($limitPoint,$point);
			if ($Gap>$limitGap) {
				var $tmp1:Number=$limitGap*Math.sin(($Angle/180)*Math.PI);
				var $tmp2:Number=$limitGap*Math.cos(($Angle/180)*Math.PI);
				$point=new Point($limitPoint.x-$tmp2,$limitPoint.y-$tmp1);
			}
			return $point;

		}
		private function GetBook_array($point:Point,$actionPoint1:Point,$actionPoint2:Point):Array {

			var array_return:Array=new Array();
			var $Gap1:Number=Math.abs(pos($actionPoint1,$point)*0.5);
			var $Angle1:Number=angle($actionPoint1,$point);
			var $tmp1_2:Number=$Gap1/Math.cos(($Angle1/180)*Math.PI);
			var $tmp_point1:Point=new Point($actionPoint1.x-$tmp1_2,$actionPoint1.y);

			var $Angle2:Number=angle($point,$tmp_point1)-angle($point,$actionPoint2);
			var $Gap2:Number=pos($point,$actionPoint2);
			var $tmp2_1:Number=$Gap2*Math.sin(($Angle2/180)*Math.PI);
			var $tmp2_2:Number=$Gap2*Math.cos(($Angle2/180)*Math.PI);
			var $tmp_point2:Point=new Point($actionPoint1.x+$tmp2_2,$actionPoint1.y+$tmp2_1);

			var $Angle3:Number=angle($tmp_point1,$point);
			var $tmp3_1:Number=book_width*Math.sin(($Angle3/180)*Math.PI);
			var $tmp3_2:Number=book_width*Math.cos(($Angle3/180)*Math.PI);

			var $tmp_point3:Point=new Point($tmp_point2.x+$tmp3_2,$tmp_point2.y+$tmp3_1);
			var $tmp_point4:Point=new Point($point.x+$tmp3_2,$point.y+$tmp3_1);

			array_return.push($point);
			array_return.push($tmp_point2);
			array_return.push($tmp_point3);
			array_return.push($tmp_point4);

			return array_return;

		}
		private function GetLayer_array($point1:Point,$point2:Point,$actionPoint1:Point,$actionPoint2:Point,$limitPoint1:Point,$limitPoint2:Point):void {

			var array_layer1:Array=new Array();
			var array_layer2:Array=new Array();
			var $Gap1:Number=Math.abs(pos($actionPoint1,$point1)*0.5);
			var $Angle1:Number=angle($actionPoint1,$point1);

			var $tmp1_1:Number=$Gap1/Math.sin(($Angle1/180)*Math.PI);
			var $tmp1_2:Number=$Gap1/Math.cos(($Angle1/180)*Math.PI);

			var $tmp_point1:Point=new Point($actionPoint1.x-$tmp1_2,$actionPoint1.y);
			var $tmp_point2:Point=new Point($actionPoint1.x,$actionPoint1.y-$tmp1_1);

			var $tmp_point3:Point=$point2;

			var $Gap2:Number=Math.abs(pos($point1,$actionPoint2));
			//---------------------------------------------
			if ($Gap2>book_height) {
				array_layer1.push($tmp_point3);
				//
				var $pos:Number=Math.abs(pos($tmp_point3,$actionPoint2)*0.5);
				var $tmp3:Number=$pos/Math.cos(($Angle1/180)*Math.PI);
				$tmp_point2=new Point($actionPoint2.x-$tmp3,$actionPoint2.y);

			} else {
				array_layer2.push($actionPoint2);
			}
			array_layer1.push($tmp_point2);
			array_layer1.push($tmp_point1);
			array_layer1.push($point1);
			bookArray_layer1=array_layer1;

			array_layer2.push($limitPoint2);
			array_layer2.push($limitPoint1);
			array_layer2.push($tmp_point1);
			array_layer2.push($tmp_point2);
			bookArray_layer2=array_layer2;

		}

		private function DrawShape(shape:Shape,point_array:Array,myBmp:BitmapData,matr:Matrix):void {

			var num:uint=point_array.length;
			shape.graphics.clear();
			shape.graphics.beginBitmapFill(myBmp,matr,false,true);

			shape.graphics.moveTo(point_array[0].x,point_array[0].y);
			for (var i:uint=1; i<num; i++) {
				shape.graphics.lineTo(point_array[i].x,point_array[i].y);
			}

			shape.graphics.endFill();

		}
		
		private function DrawShadowShap(shape:Shape,maskShape:Shape,g_width:Number,g_height:Number,$point1:Point,$point2:Point,$maskArray:Array,$arg:Number):void {

			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0x0, 0x0];
			var alphas1:Array = [0,0.5];
			var alphas2:Array = [0.5,0];
			var ratios:Array = [0, 255];
			var matr:Matrix = new Matrix();
			var spreadMethod:String = SpreadMethod.PAD;
			var myscale:Number;
			var myalpha:Number;

			shape.graphics.clear();
			matr.createGradientBox(g_width, g_height, (0/180)*Math.PI,-g_width*0.5, -g_height*0.5);

			shape.graphics.beginGradientFill(fillType, colors, alphas1, ratios, matr, spreadMethod);
			shape.graphics.drawRect(-g_width*0.5,-g_height*0.5,g_width*0.5,g_height);
			shape.graphics.beginGradientFill(fillType, colors, alphas2, ratios, matr, spreadMethod);
			shape.graphics.drawRect(0,-g_height*0.5,g_width*0.5,g_height);

			shape.x = $point2.x + ($point1.x - $point2.x) * $arg;
			shape.y = $point2.y + ($point1.y - $point2.y) * $arg;
			shape.rotation = angle($point1, $point2);
			myscale=Math.abs($point1.x-$point2.x)*0.5/book_width;
			myalpha=1-myscale*myscale;

			shape.scaleX=myscale+0.1;
			shape.alpha=myalpha+0.1;

			var tmp_Bmp:BitmapData=new BitmapData(book_width*2, book_height,true, 0x0);
			DrawShape(maskShape, $maskArray, tmp_Bmp, new Matrix());
			shape.mask=maskShape;

		}
		//End DrawPage------------------------------------------------------------------------
		
		//**Setting Parts------------------------------------------------------------------------
		private function SetFilter(obj:Object):void {
			var filter:DropShadowFilter=new DropShadowFilter();
			filter.blurX=filter.blurY=10;
			filter.alpha=0.3;
			filter.distance=2;
			filter.angle=0;
			if (SystemOS.mode == SystemOS.PC)obj.filters=[filter];
		}
		
		private function SetLoadMC():void {
			
			var u1:String;
			var u2:String;
			var u3:String;

			aLoadPage = new Vector.<Loader>()
			
			for (var nP:Number = 1; nP<=book_totalpage; nP++) {
				
				var _mc:PageFlipContent = new PageFlipContent
				book_root[sLoad + nP] = _mc
					
				_mc.id=nP;
				_mc.loadedflag=false;
				_mc.loadedtype = "";
				_mc.brotherMC =null;
				_mc.isWidthPage = false;
				
				if (nP>1) {
					u1=nodePage.children()[nP-2].attribute("src");
					u2=nodePage.children()[nP-1].attribute("src");
					if (u1==u2) {
						_mc.brotherMC=book_root[sLoad + (nP-1)];
						_mc.isWidthPage=true;
					}
				}
				_mc.loader = new Loader();
				_mc.addChild(_mc.loader);
				
				//---------------------------------------------------------------------------------------------------
				aLoadPage.push(_mc.loader)
					
			}
			nLoadPage = 0
			loadPage()
		}
		
		
		
		private function loadPage():void
		{
			if (nLoadPage<book_totalpage) 
			{
				var pageRequest:URLRequest = new URLRequest(book_path + nodePage.children()[nLoadPage].attribute("src"));
				aLoadPage[nLoadPage].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
				aLoadPage[nLoadPage].contentLoaderInfo.addEventListener(Event.COMPLETE, LoadEnd);
				aLoadPage[nLoadPage].load(pageRequest);
				nLoadPage++
			}
		}
		
		
		private function setPageMC(pageNum:Number):void {
			
			aDisplayPage = new Vector.<PageFlipContent>
			var pageL:PageFlipContent=new PageFlipContent();
			var pageR:PageFlipContent=new PageFlipContent();
			
			var _back:Sprite = new Sprite
			_back.graphics.beginFill(0x000000, 0)
			_back.graphics.drawRect(0,0,nMaskW,nMaskH)
			_back.graphics.endFill()
			pageMC.addChildAt(_back, 0)
				
			
			if (pageNum > 0 && pageNum <= book_totalpage) 
			{
				pageL = book_root[sLoad + pageNum];
				aDisplayPage.push(pageL)
				//为让最后一页白底也可以拖动，并且可以显示白色部份与首页一样
				if (pageNum == book_totalpage)pageR.addChild(_back)
			}
			
			if ((pageNum+1)>0 && pageNum+1<=book_totalpage) 
			{
				pageR = book_root[sLoad + (pageNum + 1)];
				aDisplayPage.push(pageR)
			}

			if (pageR.isWidthPage) 
			{
				pageMC.addChild(pageL);
				pageL.x = pageL.y = 0;
			} else {
				pageMC.addChild(pageL);
				pageMC.addChild(pageR);
				pageL.x = pageL.y = 0;
				pageR.x = book_width;
				pageR.y = 0;
			}

		}
		
		
		
		
		//End Setting------------------------------------------------------------------------

		//**Loader Parts------------------------------------------------------------------------
		private function LoadFindLoader(LoaderObj:Object):Number {
			var i:Number;
			var tmpageMC:PageFlipContent;
			for (i = 1; i<=book_totalpage; i++) {
				tmpageMC=book_root[sLoad + i];
				if (tmpageMC.loader.contentLoaderInfo==LoaderObj) {
					return i;
				}
			}
			return 0;
		}
		private function loadProgress(evtObj:ProgressEvent):void {
			var obj:Object=evtObj.currentTarget;
			var n:Number=(LoadFindLoader(obj));
			var percentLoaded:Number = evtObj.bytesLoaded/evtObj.bytesTotal;

			percentLoaded = Math.round(percentLoaded * 100);
			
			var _evt:PageFilpEvents = new PageFilpEvents(PageFilpEvents.onLoading)
			_evt.$setObject(book_root[sLoad + n])
			_evt.$setNum(percentLoaded)
			_evt.$setSprite(pageMC)
			dispatchEvent(_evt)
			
		}
		
		private function setBitmapSize(evtObj:Event):void
		{
			var pageFlipContent:PageFlipContent = PageFlipContent(evtObj.target.loader.parent)
			var bitmap:Bitmap = Bitmap(pageFlipContent.loader.content)
			
			if (nMaskW == 0 && nMaskH == 0) 
			{
				nMaskW = bitmap.width
				nMaskH = bitmap.height
				
				var _w:Number = nMaskW * 2
				var _h:Number = nMaskH
				setValue(0, 0, _w, _h)
				
				setPageMC(book_page);
				
				book_timer = new Timer(book_TimerNum);
				book_timer.addEventListener(TimerEvent.TIMER, bookTimerHandler);
				book_root.addEventListener(MouseEvent.MOUSE_DOWN, MouseOnDown);
				book_root.stage.addEventListener(MouseEvent.MOUSE_UP, MouseOnUp);
				dispatchEvent(new PageFilpEvents(PageFilpEvents.onResetLoc))
			}
			if (pageMode == pageFlipContent.id) dispatchEvent(new PageFilpEvents(PageFilpEvents.onLoadInit))
			bitmap.width = nMaskW
			bitmap.height = nMaskH
		}
		
		private function LoadEnd(evtObj:Event):void {
			currentPageLoader = PageFlipContent(evtObj.target.loader.parent)
			var bitmap:Bitmap = Bitmap(currentPageLoader.loader.content)
			var n:Number=currentPageLoader.id;

			currentPageLoader.loadedtype=evtObj.target.contentType;
			currentPageLoader.loadedflag = true;
			
			bitmap.smoothing = true
			setBitmapSize(evtObj)
			
			evtObj.target.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
			evtObj.target.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, LoadEnd);
			
			var _event:PageFilpEvents = new PageFilpEvents(PageFilpEvents.onLoaded)
			_event.$nPage = nLoadPage
			_event.$currentPageLoader = currentPageLoader
			dispatchEvent(_event)
			
			loadPage()
		}
		//Loader End---------------------------------------------------------------------------------

		//**MouseEvent Parts------------------------------------------------------------------------
		private function MouseOnDown(evt:Event):void {
			if (!(evt.target is Loader)) return
			if (book_TimerFlag != sTimeFlagStop  ) return; //|| evt.target.hasEventListener(MouseEvent.CLICK)
			
			var _loader:Loader = Loader(evt.target)
			var _mc:PageFlipContent = PageFlipContent(_loader.parent)
			//mouseOnDown时取area绝对值;
			book_TimerArg0 = MouseFindArea(new Point(book_root.mouseX, book_root.mouseY));
			book_TimerArg0 = book_TimerArg0 < 0? - book_TimerArg0:book_TimerArg0;
			if (book_TimerArg0 == 0) {
				//不在area区域
				return;
			} else if ((book_TimerArg0 == 1 || book_TimerArg0 == 2) && _mc.id <= 1) {
				//向左翻到顶
				return;
			} else if ((book_TimerArg0 == 3 || book_TimerArg0 == 4) && _mc.id >= book_totalpage) {
				//向右翻到顶
				return;
			} else {
				book_TimerFlag = sTimeFlag_StartPlay;
				PageUp();
			}
		}
		private function MouseOnUp(evt:Event):void {
			if (book_TimerFlag==sTimeFlag_StartPlay) {
				//处于mousedown状态时
				book_TimerArg1=MouseFindArea(new Point(book_root.mouseX,book_root.mouseY));
				book_TimerFlag=sTimeFlag_AutoPlay;
			}
		}
		private function MouseFindArea(point:Point):Number {
			/* 取下面的四个区域,返回数值:
			*   --------------------
			*  | -1|     |     | -3 |
			*  |---      |      ----|
			*  |     1   |   3      |
			*  |---------|----------| 
			*  |     2   |   4      |
			*  |----     |      ----|
			*  | -2 |    |     | -4 |
			*   --------------------
			*/
			var tmpn:Number=0
			var minX:Number=0;
			var maxX:Number = book_width + book_width;
			var minY:Number=0;
			var maxY:Number=book_height;
			var areaNum:Number=10;
			var nX:Number = 0.2
			if (point.x > minX && point.x <= maxX * nX) {
				tmpn = (point.y > minY && point.y <= (maxY * nX))?1:(point.y > maxY - (maxY * nX) && point.y < maxY)?2:0;
				if (point.x <= (minX + areaNum)) tmpn = (point.y > minY && point.y <= (minY + areaNum))? -1:(point.y > (maxY - areaNum) && point.y < maxY)? -2:tmpn;
			} else if (point.x > maxX - (maxX * nX) && point.x < maxX) {
				tmpn = (point.y > minY && point.y <= (maxY * nX))?3:(point.y > maxY - (maxY * nX) && point.y < maxY)?4:0;
				if (point.x >= (maxX - areaNum)) tmpn = (point.y > minY && point.y <= (minY + areaNum))? -3:(point.y > (maxY - areaNum) && point.y < maxY)? -4:tmpn;
			}
			return tmpn;
		}
		//End MouseEvent------------------------------------------------------------------------

		
		private function PageUp():void {
			var page1:Number;
			var page2:Number;
			var page3:Number;
			var page4:Number;
			var point_mypos:Point = book_myposArray[book_TimerArg0 - 1];
			var b0:Bitmap;
			var b1:Bitmap;
			
			if (book_TimerArg0 == 1 || book_TimerArg0 == 2) {
				book_topage = book_topage == book_page?book_page-2:book_topage;
				page1=book_page;
				page2=book_topage+1;
				page3=book_topage;
				page4=book_page+1;

			} else if (book_TimerArg0 == 3 || book_TimerArg0 == 4) {
				book_topage = book_topage == book_page?book_page + 2:book_topage;
				page1=book_page+1;
				page2=book_topage;
				page3=book_page;
				page4=book_topage+1;

			}
			
			book_px = point_mypos.x;
			book_py = point_mypos.y;

			Bmp0=PageDraw(page1);
			Bmp1=PageDraw(page2);
			bgBmp0=PageDraw(page3);
			bgBmp1=PageDraw(page4);

			b0 = new Bitmap(bgBmp0);
			b0.x = book_x
			b0.y = book_y
			
			b1 = new Bitmap(bgBmp1);
			b1.x = book_x + book_width;
			b1.y = book_y
			
			bgMC.addChild(b0);
			bgMC.addChild(b1);
			
			bgMC.visible = false;
			book_timer.start();

		}
		//End Page------------------------------------------------------------------------

		//**Timer Parts------------------------------------------------------------------------
		private function bookTimerHandler(event:TimerEvent):void {

			dispatchEvent(new PageFilpEvents(PageFilpEvents.onPagePlaying))
			
			var point_topos:Point = book_toposArray[book_TimerArg0 - 1];
			var point_mypos:Point = book_myposArray[book_TimerArg0 - 1];

			var PageObj:Object;
			var array_point1:Array;
			var array_point2:Array;
			var numpoint1:Number;
			var numpoint2:Number;

			var tmpMC0:PageFlipContent;

			var tox:Number;
			var toy:Number;
			var toflag:Number;
			var tmpx:Number;
			var tmpy:Number;

			var arg:Number;
			var r:Number;
			var a:Number;

			bgMC.visible=true;
			
			while (pageMC.numChildren > 0) {
				pageMC.removeChildAt(0);
				if (book_page>0&&book_page<=book_totalpage) {
					tmpMC0=book_root[sLoad+book_page];
					
				}
				if ((book_page+1)>0&&(book_page+1)<=book_totalpage) {
					tmpMC0=book_root[sLoad+(book_page+1)];
				
				}
			}
			
			if (book_TimerFlag==sTimeFlag_StartPlay) {
				u=0.4;
				render0.graphics.clear();
				render1.graphics.clear();
				book_px = ((render0.mouseX - book_px) * u + book_px) >> 0;
				book_py = ((render0.mouseY - book_py) * u + book_py) >> 0;

				DrawPage(book_TimerArg0, new Point(book_px, book_py), Bmp1, Bmp0);

				//book_timer.stop();

			} else if (book_TimerFlag==sTimeFlag_AutoPlay) {
				render0.graphics.clear();
				render1.graphics.clear();
				if (Math.abs(point_topos.x-book_px)>book_width&&book_TimerArg1>0) {
					//不处于点翻区域并且翻页不过中线时
					tox=point_mypos.x;
					toy=point_mypos.y;
					toflag=0;
				} else {
					tox=point_topos.x;
					toy=point_topos.y;
					toflag=1;
				}
				tmpx=(tox-book_px)>>0;
				tmpy=(toy-book_py)>>0;

				if (book_TimerArg1<0) {
					//处于点翻区域时
					u=0.3;//降低加速度
					book_py=Arc(book_width,tmpx,point_topos.y);
				} else {
					u=0.4;//原始加速度
					book_py=tmpy*u+book_py;
				}
				book_px=tmpx*u+book_px;

				DrawPage(book_TimerArg0,new Point(book_px,book_py),Bmp1,Bmp0);

				if (tmpx == 0 && tmpy == 0)
				{
					render0.graphics.clear();
					render1.graphics.clear();
					shadow0.graphics.clear();
					shadow1.graphics.clear();
					
					Bmp0.dispose();
					Bmp1.dispose();
					bgBmp0.dispose();
					bgBmp1.dispose();
					
					while (bgMC.numChildren>0) {
						bgMC.removeChildAt(0);
					}
					book_topage = toflag == 0?book_page:book_topage;
					book_page=book_topage;

					setPageMC(book_page);

					book_TimerFlag = sTimeFlagStop;//恢得静止状态
					
					bgMC.visible=false;
					book_timer.reset();
					
					dispatchEvent(new PageFilpEvents(PageFilpEvents.onPageFlipEnd))
					
				}
			}
		}
		//End Timer ------------------------------------------------------------------------

		//**Tools Parts------------------------------------------------------------------------
		private function Arc(arg_R:Number,arg_N1:Number,arg_N2:Number):Number {
			//------圆弧算法-----------------------
			var arg:Number=arg_R*2;
			var r:Number=arg_R*arg_R+arg*arg;
			var a:Number=Math.abs(arg_N1)-arg_R;
			var R_arg:Number=arg_N2 - (Math.sqrt(r-a*a)-arg);
			return R_arg;
		}
		private function angle(target1:Point,target2:Point):Number {
			var tmp_x:Number=target1.x-target2.x;
			var tmp_y:Number=target1.y-target2.y;
			var tmp_angle:Number= Math.atan2(tmp_y, tmp_x)*180/Math.PI;
			tmp_angle = tmp_angle<0 ? tmp_angle+360 : tmp_angle;
			return tmp_angle;
		}
		private function pos(target1:Point,target2:Point):Number {

			var tmp_x:Number=target1.x-target2.x;
			var tmp_y:Number=target1.y-target2.y;
			var tmp_s:Number=Math.sqrt(tmp_x*tmp_x+tmp_y*tmp_y);
			return target1.x > target2.x?tmp_s:- tmp_s;

		}
		
		
		
		
		
		
		
		
		public function init():void {
			
			book_totalpage = nodePage.children().length();
			book_page = book_topage = book_initpage;
			
			book_root.addChild(pageMC);
			book_root.addChild(bgMC);
			SetFilter(pageMC);
			SetFilter(bgMC);
			
			book_root.addChild(Mask0);
			book_root.addChild(Mask1);
			
			book_root.addChild(render0);
			book_root.addChild(shadow0);			
			book_root.addChild(render1);
			book_root.addChild(shadow1);
			
			SetLoadMC();
		}
		
		public function setPath(_path:String):void
		{
			book_path = _path
		}
		
		public function setTimerNumer(_num:uint):void
		{
			book_TimerNum = _num
		}
		
		public function setMain(_value:Sprite):void
		{
			book_root = Sprite(_value)
		}
		
		
		public function setXML(_value:XML):void
		{
			myXML = _value
			pageMode = uint(myXML.attribute("pageMode"))
			switch (pageMode) 
			{
				case 1:
					book_initpage = 0
					break;
				default:
					book_initpage = 1
					break;
			}
			
			nodePage = myXML.child(sPageNode)
			book_totalpage = Number(nodePage.children().length())
		}
		public function getContent():Sprite
		{
			return pageMC
		}
		
		public function disable():void
		{
			book_root.removeEventListener(MouseEvent.MOUSE_DOWN, MouseOnDown);
			book_root.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseOnUp);
		}
		
		public function enable():void
		{
			book_root.addEventListener(MouseEvent.MOUSE_DOWN, MouseOnDown);
			book_root.stage.addEventListener(MouseEvent.MOUSE_UP, MouseOnUp);
		}
		
		
		//**Page Parts------------------------------------------------------------------------
		public function PageToBegin():void 
		{
			PageGoto(book_initpage)
		}
		
		public function PageToEnd():void 
		{
			switch (pageMode) 
			{
				case 1:
					PageGoto(book_totalpage)
					break;
				default:
					PageGoto(book_totalpage-1)
					break;
			}
			
		}
		
		
		public function PageToNext():void
		{
			PageGoto(book_page+2)
		}
		
		
		public function PageToBack():void
		{
			switch (pageMode) 
			{
				case 1:
					PageGoto(book_page-1)
					break;
				default:
					PageGoto(book_page-2)
					break;
			}
			
		}
		
		public function PageGoto(topage:Number):void {
			var n:Number;
			switch (pageMode) 
			{
				case 1:
					topage = topage % 2 == 1?topage-1:topage;
					n = topage-book_page;
					break;
				default:
					topage = topage % 2 == 1?topage:topage;
					n = topage-book_page;
					break;
			}
			
			if (book_TimerFlag == sTimeFlagStop && topage >= 0 && topage <= book_totalpage && n != 0) {
				dispatchEvent(new PageFilpEvents(PageFilpEvents.onResetLoc))
				book_TimerArg0 = n < 0?1:3;
				book_TimerArg1 = -1;
				book_topage = topage > book_totalpage?book_totalpage:topage;
				book_TimerFlag=sTimeFlag_AutoPlay;
				PageUp();
			}else {
				dispatchEvent(new PageFilpEvents(PageFilpEvents.onGoToPageError))
				//dispatchEvent(new PageFilpEvents(PageFilpEvents.onPageFlipEnd))
			}
		}
		public function PageDraw(pageNum:Number):BitmapData {
			var myBmp:BitmapData = new BitmapData(book_width, book_height, true, 0x000000);
			if (pageNum > 0 && pageNum <= book_totalpage) {
				if (book_root[sLoad+pageNum].isWidthPage) {
					myBmp.draw(book_root[sLoad+pageNum].brotherMC, new Matrix(1,0,0,1,-book_width,0));
				} else {
					myBmp.draw(book_root[sLoad+pageNum]);
				}
			}
			return myBmp;
		}
		
		public function getCurrentPageLoader():Sprite
		{
			return currentPageLoader
		}
		
		public function getCurrentDisplayPage():Vector.<PageFlipContent>
		{
			return aDisplayPage
		}
		
		
		//End Tools------------------------------------------------------------------------
	}
}


