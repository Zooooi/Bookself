

/*

@功能：利用数学原理 绘制对变形
@params
x：Number  坐标横坐标
y：Number  坐标纵坐标
points：int  几边型  points>=3
innerRadius：Number  外半径
outerRadius:Number  内半径
angle:Number  起始角度
color:uint   十六进制符号填充颜色

@create by hery
@update 2012-5-5
@return 多边形

*/


package JsC.draw {
	import flash.display.Shape;
	import flash.display.GradientType;

	public class StarShape extends Shape
	{
		public function StarShape(x:Number=0, y:Number=0, 
									points:int=5, innerRadius:Number=20, 
									outerRadius:Number=50, angle:Number=0, color:uint=0x000) {
			
			var count = Math.abs(points); //给points取绝对值
			this.graphics.lineStyle(2, 0x85DB18); //绘制边线 宽度为2 颜色85DB18
			
			//开始填色
			this.graphics.beginFill(color);
			if (count>2) {
				// init vars
				var step, halfStep, start, n, dx, dy;
				//计算两点之间距离
				step = (Math.PI*2)/points;
				halfStep = step/2;
				//起始角度
				start = (angle/180)*Math.PI;
				this.graphics.moveTo(x+(Math.cos(start)*outerRadius), y-(Math.sin(start)*outerRadius));
				//画星状图的边
				for (n=1; n<=count; n++) {
					dx = x+Math.cos(start+(step*n)-halfStep)*innerRadius;
					dy = y-Math.sin(start+(step*n)-halfStep)*innerRadius;
					this.graphics.lineTo(dx, dy);
					dx = x+Math.cos(start+(step*n))*outerRadius;
					dy = y-Math.sin(start+(step*n))*outerRadius;
					this.graphics.lineTo(dx, dy);
				}
			}else{
				trace("points大于3")
			}
			this.graphics.endFill();
		}
	}
}