package jsProject.ctrl
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	
	import JsA.loader.LoadPDF;
	import JsA.platform.AssignLoader;
	
	import JsC.events.JEvent;
	import JsC.mdel.SystemOS;
	
	import caurina.transitions.Tweener;
	
	import jsProject.events.PageFilpEvents;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.PageFlipContent;
	import jsProject.mdel.Value;
	import jsProject.mdel.Viewers;
	
	
	[Event(name = "onLoadInit", type = "jsProject.events.PageFilpEvents")]
	[Event(name = "onLoading", type = "jsProject.events.PageFilpEvents")]
	[Event(name = "onLoadEnd", type = "jsProject.events.PageFilpEvents")]
	[Event(name = "onPageEnd", type = "jsProject.events.PageFilpEvents")]
	[Event(name = "onPagePlaying", type = "jsProject.events.PageFilpEvents")]
	[Event(name = "onResetLoc", type = "jsProject.events.PageFilpEvents")]
	[Event(name = "onRemoveAction", type = "jsProject.events.PageFilpEvents")]
	
	public class PageDrag extends UIComponent
	{
		private const sPageNode:String = NameDefine.KEY_PAGES
		private const sTimeFlagStop:String = "stop"
		private const sTimeFlag_StartPlay:String = "startplay"
		private const sTimeFlag_AutoPlay:String = "autoplay"	
		private var book_TimerFlag:String = sTimeFlagStop;
		
		[Bindable]private var nBookRect:Rectangle;
		
		private var aDisplayPage:Vector.<PageFlipContent>
		
		public var book_totalpage:uint;
		public var book_page:uint;
		public var $TimerFlag:String = sTimeFlagStop
		private var state:String = stateTwo
		private const stateOne:String ="stateOne"
		private const stateTwo:String ="stateTwo"
		
		
		private var book_path:String
		private var myXML:XML;
		private var pageMode:uint;
		private var book_initpage:int;
		private var nodePage:XMLList;
		private var currentPageContent:PageFlipContent
		private var currentPageLoader:PageFlipContent;
		private var nLoadPage:uint
		private var bSimpPage:Boolean
		private var nCount:uint
		private var nLoadPageCount:uint
		private var nLoadMode:uint
		private var act_instance:Function
		private var pageBG:Sprite = new Sprite
		private var aPage:Vector.<Sprite> = new Vector.<Sprite>
		private var bOnce:Boolean
		private var bNext:Boolean
		private var bRotation:Boolean
		private var bResize:Boolean
		private var aPageNumber:Vector.<uint>
		private var oTweenerObj1:Object
		private var oTweenerObj2:Object
		
		
		public function PageDrag()
		{
			super();
			nLoadMode = 2
			bSimpPage = false
		}
		
		public function setPath(_path:String):void
		{
			book_path = _path
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
			book_totalpage = uint(nodePage.children().length()-1)
		}
		
		public function getPageName(_num:uint):String
		{
			return nodePage.children()[_num].text.pageNumber.toString()
		}
		
		public function init():void {
			
			SetLoadMC()
		}
		
		public function setRect(_rect:Rectangle):void
		{
			nBookRect = _rect
		}
		
		public function PageToBegin():void
		{
			PageGoto(book_initpage)
		}
		
		public function PageToBack():void
		{
			if (bRotation)
			{
				book_page = nLoadPage
				bRotation = false
				
			}
			if (!bSimpPage)
			{
				if (book_page % 2==1)
				{
					PageGoto(book_page-nLoadMode)
				}else{
					PageGoto(book_page-nLoadMode-1)
				}
			}else{
				PageGoto(book_page-nLoadMode)
			}
			
			
			
		}
		
		
		public function PageToNext():void
		{
			if (bRotation)
			{
				book_page = nLoadPage
				bRotation = false
			}
			if (!bSimpPage)
			{
				if (book_page % 2 ==1)
				{
					PageGoto(book_page+nLoadMode)
				}else{
					PageGoto(book_page+1)
				}
			}else{
				PageGoto(book_page+1)
			}
			
		}
		
		public function PageToEnd():void
		{
			PageGoto(book_totalpage-1)
		}
		
		public function disable():void
		{
			
		}
		
		public function enable():void
		{
			
		}
		
		
		
		
		public function getCurrentDisplayPage():Vector.<PageFlipContent>
		{
			return aDisplayPage
		}
		
		
		
		
		private function SetLoadMC():void
		{
			nLoadPage = 0
			loadPage(1)
		}
		
		
		private function loadPage(_num:uint=1):void
		{
			aPageNumber = new Vector.<uint>
			aDisplayPage = new Vector.<PageFlipContent>
			nCount = 0
			nLoadPageCount = _num
			currentPageContent = new PageFlipContent
			loadAction()
		}
		
		private function loadAction():void
		{
			trace(currentPageContent.numChildren)
			aPageNumber.push(nLoadPage)
			var pageFile:String = nodePage.children()[nLoadPage].attribute("src")
			var pageRequest:URLRequest = new URLRequest(book_path + pageFile)
			//trace(nLoadPage,book_path + pageFile)
			
			
			/*if (pageFile.lastIndexOf(".pdf")>0 || pageFile.lastIndexOf(".html")>0 || pageFile.lastIndexOf(".htm")>0)
			{
			var _pdfLoader:LoadPDF = new LoadPDF
			_pdfLoader.addEventListener(JEvent.COMPLETE,onLoadPDFComplete)
			_pdfLoader.load(pageRequest)
			}else{*/
			var picLoader:Loader = new Loader
			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPicComplete);
			picLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadPicError);
			
			var al:AssignLoader = new AssignLoader
			al.setLoader(picLoader,book_path + pageFile)
			
			/*}*/
		}
		
		
		
		protected function onLoadPDFComplete(event:JEvent):void
		{
			currentPageLoader = new PageFlipContent()
			currentPageLoader.id = nLoadPage
			currentPageContent.addChild(currentPageLoader)
			
			var _sprite:Sprite = event.$getSprite()
			currentPageLoader.addChild(_sprite)
			onLoadEndAction()
		}		
		
		private function onLoadPicComplete(evtObj:Event):void 
		{
			currentPageLoader = new PageFlipContent()
			currentPageLoader.id = nLoadPage
			currentPageContent.addChild(currentPageLoader)
			
			var bitmap:Bitmap = Bitmap(evtObj.target.content)
			bitmap.smoothing = true
			bitmap.cacheAsBitmap = true
			currentPageLoader.addChild(bitmap)
			evtObj.target.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadPicComplete);
			
			onLoadEndAction()
		}
		
		
		protected function onLoadPicError(event:Event):void
		{
			trace(this,event.type,event);
			
		}
		
		
		private function onLoadEndAction():void
		{
			aDisplayPage.push(currentPageLoader)
			currentPageLoader.x = currentPageLoader.width * nCount 
			
			var _event:PageFilpEvents = new PageFilpEvents(PageFilpEvents.onLoaded)
			_event.$nPage = nLoadPage + 1
			_event.$currentPageLoader = currentPageLoader
			dispatchEvent(_event)
			
			nCount ++
			if (nCount<nLoadPageCount)
			{
				if (nLoadPage<book_totalpage)
				{
					nLoadPage ++ 
						loadAction()
				}else{
					loadedAndAction()
				}
			}else{
				loadedAndAction()
			}
		}
		
		private function loadedAndAction():void
		{
			aPage.push(currentPageContent)
			addChild(currentPageContent)
			if (!bOnce)
			{
				act_init(PageFilpEvents.onLoadInit)
				bOnce = true
			}else{
				act_trans()
			}
		}
		
		private function act_init(_type:String):void
		{
			trace("act_init",_type)
			var _event:PageFilpEvents = new PageFilpEvents(_type)
			_event.$nPage = nLoadPage + 1
			_event.$currentPageContent = currentPageContent
			dispatchEvent(_event)
		}		
		
		
		private function act_trans():void
		{
			trace("act_trans")
			var _bNext:Boolean
			var _nC:Number = 0
			var _nX:Number = 0 
			var _nY:Number = 0 
			var _oX:Number = nBookRect.width * 0.3
			var _sprite:Sprite = aPage[0]	
			currentPageContent.height = _sprite.height
			currentPageContent.scaleX = currentPageContent.scaleY
			currentPageContent.y = _sprite.y
			if (currentPageContent.height<nBookRect.height)
			{
				_nY = nBookRect.y 
			}else 
			{
				_nY =  nBookRect.y + (nBookRect.height-currentPageContent.height) / 2
			}
			_nC = nBookRect.x + (nBookRect.width - currentPageContent.width )/2	
			
			book_page = (nLoadPage - 1<0)?0:nLoadPage
			
			if (!bRotation)
			{
				if(bNext)
				{
					currentPageContent.x = nBookRect.x  + nBookRect.width + _oX 
					_nX =  nBookRect.x - _sprite.width - _oX
				}else{
					currentPageContent.x = nBookRect.x  - currentPageContent.width - _oX
					_nX =  nBookRect.x  + nBookRect.width + _oX 
				}
				
				var _t:Number
				if (SystemOS.isPc)
				{
					_t = 0.8
					oTweenerObj1 = {x:_nX,time:_t}
					Tweener.addTween(_sprite, oTweenerObj1);
				}else{
					_t = 0.4
					onFinish()
				}
				oTweenerObj2 = {x:_nC,y:_nY,time:_t ,onComplete:onTransComplete}
				Tweener.addTween(currentPageContent, oTweenerObj2);
				
			}else{
				currentPageContent.x = _nC
				currentPageContent.y = _nY
				onFinish()
				act_init(PageFilpEvents.onPageFlipEnd)
			}
		}
		
		private function onTransComplete():void
		{
			Tweener.removeTweens(currentPageContent, oTweenerObj2);
			if (SystemOS.isMobile)
			{
				
			}else{
				onFinish()
			}
			act_init(PageFilpEvents.onPageFlipEnd)
		}
		
		
		private function onFinish():void
		{
			if (aPage[0].parent!=null)
			{
				removeChild(aPage[0])
				aPage[0]=null
			}
			aPage.splice(0,1)
		}
		
		public function setShowPageNumber(_num:uint):void
		{
			nLoadMode = _num
			bRotation = true
			var _page:uint = book_page
			switch(_num)
			{
				case 2:
					if (book_page==0)
					{
						_page = 0
					}else if (book_page % 2==0){
						_page = book_page-1
					}
					break;
			}
			pagoGotoAction(_page)
		}
		
		public function setOnePage(_resize:Boolean = false):void
		{
			if (_resize==false)state = stateOne
			setShowPageNumber(1)
			bSimpPage =true
		}
		
		public function setTwoPage(_resize:Boolean = false):void
		{
			if (_resize==false)state = stateTwo
			switch(state)
			{
				case stateOne:
					setShowPageNumber(1)
					break;
				case stateTwo:
					setShowPageNumber(2)
					break;
				
			}
			
			bSimpPage = false
		}
		
		public function PageGoto(topage:Number):void 
		{
			trace("------------------------------------------")
			trace("PageGoto",topage)
			var bPass:Boolean
			if (topage>book_totalpage) topage = book_totalpage
			if (topage<0)topage = 0
			
			if (topage!=0)
			{
				if(bSimpPage)
				{
					if (topage == book_page)
					{
						bPass = true
					}
				}else{
					if (topage % 2 ==1)
					{
					}else{
						topage --
					}
					if (topage+1 == book_page)
					{
						bPass = true 
					}
				}
			}else{
				if (topage == book_page)
				{
					bPass = true
				}
			}
			
			if (bPass)
			{
				//重復
				dispatchEvent(new PageFilpEvents(PageFilpEvents.onGoToPageError))
			}
			else
			{
				pagoGotoAction(topage)
			}
		}
		
		private function pagoGotoAction(topage:Number):void 
		{
			if (topage >= 0 && topage <= book_totalpage && topage != book_page || bRotation) 
			{
				dispatchEvent(new PageFilpEvents(PageFilpEvents.onRemoveAction))
				nLoadPage = topage
				if (topage>book_page)
				{
					//next
					bNext = true
				}else{
					//back
					bNext = false
				}
				if (topage==0)
				{
					loadPage(1)
				}else{
					loadPage(nLoadMode)
				}
			}
			else 
			{
				dispatchEvent(new PageFilpEvents(PageFilpEvents.onGoToPageError))
				//act_init((PageFilpEvents.onPageFlipEnd))
			}
		}
		
		public function getContent():PageFlipContent
		{
			return currentPageContent
		}
		
		public function getSimpage():Boolean
		{
			return bSimpPage
		}
		
		public function setEvent():void
		{
			if (SystemOS.isMobile)
			{
				Viewers.getBook().addEventListener(JEvent.RESIZE,onStageEvent)
				var _bCompare:Boolean = stage.stageWidth>stage.stageHeight
				if (_bCompare)
				{
					nLoadMode = 2
					bSimpPage = false
				}else{
					nLoadMode = 1
					bSimpPage = true
				}
			}
		}
		
		protected function onStageEvent(event:JEvent):void
		{
			var _bCompare:Boolean = stage.stageWidth>stage.stageHeight
			if (SystemOS.isMobile)
			{
				if (Value.bStageSize)
				{
					if (_bCompare)
					{
						if (state == stateTwo)
						{
							setTwoPage(true)
						}
					}else{
						if (state == stateTwo)
						{
							setOnePage(true)
						}
					}
				}else
				{
					if (_bCompare)
					{
						if (state == stateTwo)
						{
							setOnePage(true)
						}
					}else{
						if (state == stateTwo)
						{
							setTwoPage(true)
						}
					}
				}
			}
		}
		
		public function getPageNumber():Vector.<uint>
		{
			return aPageNumber
		}
		
	}
}