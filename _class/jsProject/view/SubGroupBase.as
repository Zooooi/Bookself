package jsProject.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.XmlContent;
	
	
	public class SubGroupBase extends Sprite
	{
		
		protected const sPagePath:String = Files.folder_book
			
		protected var defAlpha:Number = 0.2
		protected var defBlend:String = BlendMode.NORMAL
			
		protected var myXML:XML
			
		protected var cHightLight:Sprite;
		
		protected var currentParaIndex:uint
		protected var currentParaXML:XML
		
		protected var currentShapeXML:XML
		protected var currentShapeIndex:uint
		
		protected var sPath:String 
		protected var currentLangugeIndex:uint
		protected var currentLangugeXML:XML
		
		protected var aPlayState:Vector.<Boolean>
		protected var aBigButton:Vector.<IconButtonSprite>
		protected var aKindButton:Vector.<IconButtonSprite>
		protected var aPlayAllButton:Vector.<IconButtonSprite>
		
		protected var nCount:uint
		protected var bPlayAllState:Boolean
		protected var bAct:Boolean
		protected var aButtons:Vector.<Vector.<SubGroup_ButtonData>>
		protected var aPlayAll:Vector.<SubGroup_ButtonData>
		protected var aPlayList:Vector.<SubGroup_ButtonData>
		protected var aGroupText:Vector.<String>
		
		protected var aClick:Vector.<Boolean>
		protected var aSmallClick:Vector.<Vector.<Boolean>>
		
		public function SubGroupBase()
		{
			super();
			aPlayAll = new Vector.<SubGroup_ButtonData>
			bPlayAllState = false
			aButtons = new Vector.<Vector.<SubGroup_ButtonData>>
			aPlayState = new Vector.<Boolean>
			aBigButton = new Vector.<IconButtonSprite>
			aKindButton = new Vector.<IconButtonSprite>
			aGroupText = new Vector.<String>
		}
		
		public function setXML(_xml:XML):void
		{
			myXML = _xml
			inst()
		}
		
		protected function inst():void
		{
			sPath = sPagePath + myXML.@path + "/"
			x = myXML.@contentX
			y = myXML.@contentY
				
			var i:int
			var j:int
			var k:int
			
			nCount = 0
			for (i = 0; i < myXML.language.length(); i++) 
			{
				getCurrentLangugeXML(i)
				aPlayState.push(!bAct)
				var abut:Vector.<SubGroup_ButtonData> = new Vector.<SubGroup_ButtonData>
				aButtons.push(abut)
				setupUnitButton(addLangugeButton(i))
				onAddLanguageChildButton(i)
				
			}
			var xmlListAdv:XMLList 
			xmlListAdv = myXML.advance
				
			aPlayAllButton = new Vector.<IconButtonSprite>
			for (i =0; i < xmlListAdv.playAll.length(); i++) 
			{
				var _xmlList:XMLList = XMLList(xmlListAdv.playAll[i])
				var playAllBtn:IconButtonSprite = new IconButtonSprite
				playAllBtn.$setData(Files.folder_components,(XmlContent.XML_COMPONENT.children().(@componentID==_xmlList.@id)))
				playAllBtn.$setXML(XML(_xmlList))
				playAllBtn.addEventListener(MouseEvent.CLICK,onPlayAllMouseEvent)
				aPlayAllButton.push(playAllBtn)
				addChild(playAllBtn)	
			}
			
			xmlListAdv = myXML.advance.kinds
			for (j = 0; j < xmlListAdv.children().length(); j++) 
			{
				var _item:IconButtonSprite = new IconButtonSprite
				var currentPartXML:XML = xmlListAdv.children()[j]
				if (currentPartXML.@id!="")
				{
					_item.$setData(Files.folder_components,(XmlContent.XML_COMPONENT.children().(@componentID==currentPartXML.@id)))
					_item.$setLoc(currentPartXML.@x,currentPartXML.@y,currentPartXML.@width,currentPartXML.@height)
					_item.addEventListener(MouseEvent.CLICK,onPlayKindMouseEvent)
					addChild(_item)
					aKindButton.push(_item)
					aGroupText.push(currentPartXML.@group)
				}else{
					aKindButton.push(null)
				}
			}
			changeToLineArray()
		}
		
		private function onAddLanguageChildButton(i:uint):void
		{
			var j:int
			var k:int
			
			getCurrentLangugeXML(i)
			
			var abut:Vector.<SubGroup_ButtonData> = aButtons[i]
			for (j = 0; j < currentLangugeXML.children().length(); j++) 
			{
				getCurrentParaXML(j)
				var _buttonData:SubGroup_ButtonData = new SubGroup_ButtonData
				var _sprite:Sprite = new Sprite
				if (currentLangugeXML.@active == "1" || currentParaXML.@active == "0")
				{
					//按鍵禁止
					_sprite.mouseChildren = false
					_sprite.mouseEnabled = false
				}
				
				if (currentLangugeXML.@force == "1" || currentParaXML.@force == "1")
				{
					//對應的mp3強制有聲
					_buttonData.force = true
				}
				
				var _file:String = sPath + String(currentParaXML.@file)	
				for (k = 0; k < currentParaXML.children().length(); k++)
				{
					addShape(currentParaXML.child(k),_sprite)
				}
				_buttonData.btn = _sprite
				_buttonData.file = _file
				_buttonData.index = nCount
				_buttonData.state = bAct
				
				abut.push(_buttonData)
				setupShapeButton(_sprite)
				addChild(_sprite)
				nCount++
			}
		}
		
		protected function onPlayAllMouseEvent(event:MouseEvent):void
		{
			
		}		
		
		protected function onPlayKindMouseEvent(event:MouseEvent):void
		{
			
		}
		
		
		protected function searchSmallID(_btn:Sprite):Vector.<uint>
		{
			var _ve:Vector.<uint>
			for (var i:int = 0; i < aButtons.length; i++) 
			{
				for (var j:int = 0; j < aButtons[i].length; j++) 
				{
					if ( aButtons[i][j].btn==_btn)
					{
						_ve = new Vector.<uint>
						_ve.push(i,j)
					}
				}
				
			}
			return _ve
		}
		
		protected function searchSmallButtonData(_btn:Sprite):SubGroup_ButtonData
		{
			var _ve:Vector.<uint> = searchSmallID(_btn)
			var i:uint = _ve[0]
			var j:uint = _ve[1]
			return aButtons[i][j]
		}
		
		
		protected function searchObjectInLine(_inObject:Object):SubGroup_ButtonData
		{
			var _index:int
			var i:int
			var _obj:SubGroup_ButtonData
			for (i = 0; i < aPlayAll.length; i++) 
			{
				if (_inObject is Sprite)
				{
					if (aPlayAll[i].btn == _inObject)
					{
						_obj = aPlayAll[i]
						break
					}
				}else if (_inObject is String){
					if (aPlayAll[i].file == _inObject)
					{
						_obj = aPlayAll[i]
						break
					}
				}
			}
			return _obj
		}
		
		protected function getCurrentLangugeXML(_num:int=-1):XML
		{
			if (_num!=-1) currentLangugeIndex = _num
			currentLangugeXML=myXML.language[currentLangugeIndex]
			return currentLangugeXML
		}
		
		protected function getCurrentParaXML(_num:int=-1):XML
		{
			if (_num!=-1) currentParaIndex = _num
			currentParaXML = getCurrentLangugeXML().children()[currentParaIndex]
			return currentParaXML
		}
		
		protected function getCurrentShapeXML(_num:int=-1):XML
		{
			if (_num!=-1) currentShapeIndex = _num
			currentShapeXML = getCurrentParaXML().children()[currentShapeIndex]
			return currentShapeXML
		}
		
		protected function setupUnitButton(_btn:IconButtonSprite):void
		{
			
		}
		
		protected function setActUnitButton(_btn:IconButtonSprite):void
		{
			
		}
		
		protected function setupShapeButton(_btn:Sprite):void
		{
		}
		
		
		protected function addLangugeButton(_num:uint):IconButtonSprite
		{
			var _item:IconButtonSprite = new IconButtonSprite
			if (currentLangugeXML.@id!="")
			{
				_item.$setData(Files.folder_components,XmlContent.updataButtonsXML(currentLangugeXML.@id,currentLangugeXML))
			}else{
				_item.visible = false
			}
			_item.index = _num
			addChild(_item)
			aBigButton.push(_item)
			return _item
		}
		
		
		protected function addShape(_xmlList:XMLList,_sprite:Sprite):void
		{
			var _x:Number = Number(_xmlList.@x)
			var _y:Number = Number(_xmlList.@y)
			var _w:Number = Number(_xmlList.@width)
			var _h:Number = Number(_xmlList.@height)
			var _c:uint = uint(currentLangugeXML.@color)
			cHightLight = new Sprite
			cHightLight.buttonMode = true
			cHightLight.blendMode = defBlend
			cHightLight.graphics.clear()
			cHightLight.graphics.beginFill(_c, defAlpha);
			cHightLight.graphics.drawRect(0,0,_w,_h)
			cHightLight.graphics.endFill()
			cHightLight.x = _x
			cHightLight.y = _y
			_sprite.addChild(cHightLight)
		}
		
		
		protected function changeToLineArray(_num:uint=0):void
		{
			var i:int
			var _b:Boolean
			for (i = 0; i < aButtons.length; i++) 
			{
				for (var j:int = 0; j < aButtons[i].length; j++) 
				{
					aPlayAll.push(aButtons[i][j])
				}
			}
		}
		
		
		protected function changeToLineArray2(_num:uint=0):void
		{
			var i:int
			var _b:Boolean
			for (i = 0; i < aButtons.length; i++) 
			{
				if (_num<=aButtons[i].length-1)
				{
					aButtons[i][_num].index = nCount
					aPlayAll.push(aButtons[i][_num])
					_b = true
					nCount++
				}
			}
			
			if (_b) 
			{
				_num++
				changeToLineArray(_num)
			}
		}
		
		
		
		
	}
}

