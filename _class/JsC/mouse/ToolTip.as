
package JsC.mouse{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.filters.DropShadowFilter;
	import flash.utils.Timer;


	public class ToolTip extends Sprite {
		private  var _stage:Stage;//注，tooltip必须加到stage下
		private  var txtColor:uint=0x000000;//tips文本顏色
		private  var txtSize:uint=12;//label文本字體大小
		private  var borderColor:uint=0x000000;//tips邊框顏色
		private  var bgColor:uint=0xFFFFCC;//tips背景顏色
		private  var maxTxtWidth:Number=200;//label文本最大寬度
		private  var uniqueInstance:ToolTip;
		private  var mouseBistance:int=0;//tips與鼠標距離
		private  var topBistance:int=0;//tips頂端極限像素
		private  var rightBistance:int=0;//tips右邊極限像素
		private  var arrowHeight:uint=8;//箭頭高度
		private  var _stageWidth:uint;//容器寬度
		private  var position:uint=1;//方位記錄
		private  var txtWidth:Number;//label文本寬度
		private  var txtHeight:Number;//label文本高度
		private  var timer:Timer;
		private  var alphaSpeed:Number=0.005;//tips透明度遞增加速度
		private  var alphaStep:Number=0;//tips透明度遞增步長
		//
		private var TipsArr:Array;
		private var tipTxt:TextField;
		//
		public function ToolTip() {

			super();
			TipsArr=new Array  ;
			timer=new Timer(30);
			timer.addEventListener("timer",timerHandler);


		}
		//获取全局唯一实例
		private  function getInstance():ToolTip {
			if (uniqueInstance==null) {
				uniqueInstance=new ToolTip  ;
				uniqueInstance.visible=false;
				uniqueInstance.tipTxt=new TextField  ;
				uniqueInstance.tipTxt.autoSize=TextFieldAutoSize.LEFT;
				uniqueInstance.tipTxt.selectable=false;
				uniqueInstance.addChild(uniqueInstance.tipTxt);
				//
				_stage.addChild(uniqueInstance);

			}
			return uniqueInstance;
		}
		//清空tooltips，注：不是隐藏所有，而是彻底清空，如果要隐藏，某一时刻又显示出来的话，采用hide和show
		public  function removeAllTips():void {
			for (var i:int=0; i < getInstance().DOTips.length; i++) {
				getInstance().DOTips[i].DO.removeEventListener(MouseEvent.ROLL_OVER,showTip);
				getInstance().DOTips[i].DO.removeEventListener(MouseEvent.ROLL_OUT,hideTip);
				getInstance().DOTips[i].DO.removeEventListener(MouseEvent.MOUSE_MOVE,moveTip);
				getInstance().DOTips[i]=null;
			}
			_stage.removeChild(getInstance());
			uniqueInstance=null;

		}
		//暂时隐藏
		public  function hideToolTip():void {
			_stage.removeChild(getInstance());
		}
		//再次show
		public  function showToolTip():void {
			_stage.addChild(getInstance());
		}
		//添加某DO的tip注冊
		public  function register(DO:DisplayObject,info:String):void {
			//test if already been binded
			if (testRegister(DO)==-1) {
				//add to array
				var dotip:Object={DO:DO,info:info};
				getInstance().DOTips.push(dotip);
				//
				DO.addEventListener(MouseEvent.ROLL_OVER,showTip);
				DO.addEventListener(MouseEvent.ROLL_OUT,hideTip);
				DO.addEventListener(MouseEvent.MOUSE_MOVE,moveTip);
			}
		}
		//去除某DO的tip注冊
		public  function removeTip(DO:DisplayObject):void {
			if (testRegister(DO)!=-1) {
				for (var i:int=testRegister(DO); i < getInstance().DOTips.length - 1; i++) {
					getInstance().DOTips[i]=getInstance().DOTips[i+1];
				}
				getInstance().DOTips.pop();
				DO.removeEventListener(MouseEvent.ROLL_OVER,showTip);
				DO.removeEventListener(MouseEvent.ROLL_OUT,hideTip);
				DO.removeEventListener(MouseEvent.MOUSE_MOVE,moveTip);
			}
		}
		//更改某注冊DO的文字信息
		public  function setTipInfo(DO:DisplayObject,info:String):void {
			if (testRegister(DO)==-1) {
				register(DO,info);
			} else {
				getInstance().DOTips[testRegister(DO)].info=info;
			}
		}//测试是否已经注冊，注冊则返回数组中的次序，否则返回-1
		public  function testRegister(DO:DisplayObject):int {
			var flag:Boolean=false;
			for (var i:int=0; i < getInstance().DOTips.length; i++) {
				if (getInstance().DOTips[i].DO==DO) {
					flag=true;
					break;
				}
			}
			return flag?i:-1;
		}
		//

		private  function checkPosition(sX:Number,sY:Number) {

			if (sY-txtHeight-arrowHeight>3) {
				if (sX+txtWidth-rightBistance-8<_stageWidth) {
					getInstance().x=sX-7;

					if (position!=1) {
						drawTipBg(1);
						position=1;
					}

				} else {
					getInstance().x=sX-txtWidth+8;
					if (position!=2) {
						drawTipBg(2);
						position=2;
					}
				}
				getInstance().y=sY-txtHeight-arrowHeight-mouseBistance-4;
			} else {
				if (position!=3) {
					drawTipBg(3);
					position=3;
				}
				getInstance().y=sY+22+mouseBistance;
				if (sX+txtWidth-rightBistance+1<_stageWidth) {
					getInstance().x=sX;
				} else {
					getInstance().x=_stageWidth-txtWidth+rightBistance-1;
				}
			}
		}
		public  function drawTipBg(position:int):void {
			//

			var gp:Graphics=getInstance().graphics;
			gp.clear();
			gp.lineStyle(0,borderColor);
			gp.beginFill(bgColor);
			//
			//gp.drawRect (0,0,txtWidth,txtHeight);
			switch (position) {

				case 1 ://tip位于象限1
					gp.moveTo(0,4);
					gp.curveTo(0,0,4,0);
					gp.lineTo(txtWidth - 4,0);
					gp.curveTo(txtWidth,0,txtWidth,4);
					gp.lineTo(txtWidth,txtHeight - 4);
					gp.curveTo(txtWidth,txtHeight,txtWidth - 4,txtHeight);
					//---箭頭--
					gp.lineTo(16,txtHeight);
					gp.curveTo(8,txtHeight + arrowHeight / 2,8,txtHeight + arrowHeight);
					gp.curveTo(8,txtHeight + arrowHeight / 4,6,txtHeight);
					//---------
					gp.lineTo(4,txtHeight);
					gp.curveTo(0,txtHeight,0,txtHeight - 4);
					//gp.lineTo (-1,txtHeight-4);
					//gp.lineTo (-1,4);
					gp.lineTo(0,4);
					break;
				case 2 ://tip位于象限2
					gp.moveTo(0,4);
					gp.curveTo(0,0,4,0);
					gp.lineTo(txtWidth - 4,0);
					gp.curveTo(txtWidth,0,txtWidth,4);
					gp.lineTo(txtWidth,txtHeight - 4);
					gp.curveTo(txtWidth,txtHeight,txtWidth - 4,txtHeight);
					//---箭頭--
					gp.lineTo(txtWidth - 6,txtHeight);
					gp.curveTo(txtWidth - 8,txtHeight + arrowHeight / 2,txtWidth - 8,txtHeight + arrowHeight);
					gp.curveTo(txtWidth - 8,txtHeight + arrowHeight / 2,txtWidth - 16,txtHeight);
					//---------
					gp.lineTo(4,txtHeight);
					gp.curveTo(0,txtHeight,0,txtHeight - 4);
					//gp.lineTo (-1,txtHeight-4);
					//gp.lineTo (-1,4);
					gp.lineTo(0,4);
					break;
				case 3 ://tip位于象限3,4
					gp.moveTo(0,4);
					gp.curveTo(0,0,4,0);
					gp.lineTo(txtWidth - 4,0);
					gp.curveTo(txtWidth,0,txtWidth,4);
					gp.lineTo(txtWidth,txtHeight - 4);
					gp.curveTo(txtWidth,txtHeight,txtWidth - 4,txtHeight);
					//---箭頭--
					//gp.lineTo (15,txtHeight);
					//gp.curveTo (10,txtHeight+arrowHeight/4,8,txtHeight+arrowHeight);
					//gp.curveTo (10,txtHeight+arrowHeight/2,5,txtHeight);
					//---------
					gp.lineTo(4,txtHeight);
					gp.curveTo(0,txtHeight,0,txtHeight - 4);
					//gp.lineTo (-1,txtHeight-4);
					//gp.lineTo (-1,4);
					gp.lineTo(0,4);
					break;
				default :

					break;
			}
			gp.endFill();
			getInstance().filters=[new DropShadowFilter(6,45,0x000000,0.5,5,5,1,1)];
		}
		//---------------
		private  function hideTip(evt:MouseEvent):void {
			getInstance().visible=false;
		}
		private  function moveTip(evt:MouseEvent):void {
			checkPosition(evt.stageX,evt.stageY);
		}
		private  function updateTip():void {
			getInstance().tipTxt.textColor=txtColor;
			if (getInstance().tipTxt.width>maxTxtWidth) {
				getInstance().tipTxt.wordWrap=true;
				getInstance().tipTxt.width=maxTxtWidth;
			}
			var tf:TextFormat=new TextFormat;
			tf.size=txtSize;
			getInstance().tipTxt.setTextFormat(tf);
			txtWidth=getInstance().tipTxt.width;
			txtHeight=getInstance().tipTxt.height;


		}
		private  function timerHandler(evt:TimerEvent):void {
			if (getInstance().alpha<1) {
				if (getInstance().tipTxt.width) {
					getInstance().alpha+=alphaStep;
					alphaStep+=alphaSpeed;
				}else{
					updateTip()
				}
			} else {
				timer.stop();
			}
		}
		private  function showTip(evt:MouseEvent):void {

			getInstance().tipTxt.wordWrap=false;
			getInstance().tipTxt.text=getInstance().DOTips[testRegister(evt.target as DisplayObject)].info;

			updateTip();

			checkPosition(evt.stageX,evt.stageY);
			//抽出畫tipBg
			drawTipBg(position);
			getInstance().alpha=0;
			getInstance().visible=true;
			alphaStep=0;
			timer.start();
		}
		//
		public  function set stage(stage:Stage):void {
			_stage=stage;
			_stageWidth=stage.stageWidth;
		}
		//
		private function get DOTips():Array {
			return TipsArr;
		}
		//修改label文本屬性
		public  function setTipLabelProperty(txt_color:uint=0x000000,txt_size:uint=12,max_txt_width:int=200):void {
			txtColor=txt_color;
			txtSize=txt_size;
			maxTxtWidth=max_txt_width;
		}
		//修改tip背景屬性
		public  function setTipBgProperty(bg_color:uint=0xFFFFCC,border_color:uint=0x000000,arrow_height:uint=8):void {
			bgColor=bg_color;
			borderColor=border_color;
			arrowHeight=arrow_height;
		}
		//修改toopTip顯示屬性
		public  function setToolTipProperty(mouse_bistance:int=0,right_bistance:int=0,top_bistance:int=0,alpha_speed:Number=0.005):void {
			mouseBistance=mouse_bistance;
			rightBistance=right_bistance;
			topBistance=top_bistance;
			alphaSpeed=alpha_speed;
		}
	}
}