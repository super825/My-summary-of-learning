var canvas = document.getElementById("canvas");
var cxt = canvas.getContext("2d");

//获取工具按钮的标签
//获取画笔标签
var Brush = document.getElementById("means_brush");
//获取橡皮标签
var Eraser = document.getElementById("means_eraser");
//获取油漆桶标签
var Paint = document.getElementById("means_paint");
//获取吸管标签
var Straw = document.getElementById("means_straw");
//获取文本标签
var Text = document.getElementById("means_text");
//获取放大镜标签
var Magnifier = document.getElementById("means_magnifier");

//获取形状按钮的标签
//获取画线标签
var Line = document.getElementById("shape_line");
//获取画圆圈的标签
var Arc = document.getElementById("shape_arc");
//获取画方框的标签
var Rect = document.getElementById("shape_rect");
//获取画多标签的标签
var Poly = document.getElementById("shape_poly");
//获取画圆形(填充)
var ArcFill = document.getElementById("shape_arcfill");
//获取画矩形的标签
var RectFill = document.getElementById("shape_rectfill");
//把12个工具和形状标签放到一个数组中
var actions = [
  Brush,
  Eraser,
  Paint,
  Straw,
  Text,
  Magnifier,
  Line,
  Arc,
  Rect,
  Poly,
  ArcFill,
  RectFill
];

//获取线宽按钮
var Line_1 = document.getElementById("width_1");
var Line_3 = document.getElementById("width_3");
var Line_5 = document.getElementById("width_5");
var Line_8 = document.getElementById("width_8");
//把4中线宽对象放到一个数组中
var widths = [Line_1, Line_3, Line_5, Line_8];

//获取颜色按钮
var ColorRed = document.getElementById("red");
var ColorGreen = document.getElementById("green");
var ColorBlue = document.getElementById("blue");
var ColorYellow = document.getElementById("yellow");
var ColorWhite = document.getElementById("white");
var ColorBlack = document.getElementById("black");
var ColorPink = document.getElementById("pink");
var ColorPurPle = document.getElementById("purple");
var ColorCyan = document.getElementById("cyan");
var ColorOrange = document.getElementById("orange");
//把10中颜色标签对象放到一个数组中
var colors = [
  ColorRed,
  ColorGreen,
  ColorBlue,
  ColorYellow,
  ColorWhite,
  ColorBlack,
  ColorPink,
  ColorPurPle,
  ColorCyan,
  ColorOrange
];

//设置初始值
//默认选中画笔工具
drawBrush(0);
//默认设置颜色
setColor(ColorRed, 0);
//设置默认线宽
setLineWidth(0);

//状态设置函数
function setStatus(Arr, num, type) {
  for (var i = 0; i < Arr.length; i++) {
    //设置选中的标签改变CSS属性
    if (i == num) {
      //设置改变CSS的样式是背景色还是边框
      if (type == 1) {
        Arr[i].style.background = "yellow";
      } else {
        Arr[i].style.border = "1px solid #fff";
      }
    } else {
      //设置未选中的组中的其他标签改变颜色
      if (type == 1) {
        Arr[i].style.background = "#ccc";
      } else {
        Arr[i].style.border = "1px solid #000";
      }
    }
  }
}

//设置图像功能函数  保存图片  清空画布
function saveimg() {
  var imgdata = canvas.toDataURL();
  var b64 = imgdata.substring(22);
  //alert(b64);
  //将form表单中的隐藏表单 赋值(值就是我们获取的b64)
  var data = document.getElementById("data");
  data.value = b64;
  //将表单提交到后台//http://localhost/down.php
  var form = document.getElementById("myform");
  form.submit();
}
//清空画布
function clearimg() {
  //画布清除方法
  cxt.clearRect(0, 0, 880, 400);
}

//列出所有的按钮对应的函数
//铅笔工具函数
function drawBrush(num) {
  setStatus(actions, num, 1);
  var flag = 0; //设置标志位->检测鼠标是否按下
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    var startX = evt.pageX - this.offsetLeft;
    var startY = evt.pageY - this.offsetTop;
    cxt.beginPath();
    cxt.moveTo(startX, startY);
    flag = 1;
  };

  //鼠标移动的时候->不同的绘图(获取鼠标的位置)
  canvas.onmousemove = function(evt) {
    evt = window.event || evt;
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    //判断一下鼠标是否按下
    if (flag) {
      //移动的时候设置路径并且画出来
      cxt.lineTo(endX, endY);
      cxt.stroke();
    }
  };

  //鼠标抬起的时候结束绘图
  canvas.onmouseup = function() {
    flag = 0;
  };

  //鼠标移出canvas的时候必须取消画图操作
  canvas.onmouseout = function() {
    flag = 0;
  };
}

var eraserFlag = 0; //设置橡皮擦的状态标志位
//橡皮工具函数
function drawEraser(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    var eraserX = evt.pageX - this.offsetLeft;
    var eraserY = evt.pageY - this.offsetTop;
    //canvas擦出方法 cxt.clearRect();
    cxt.clearRect(
      eraserX - cxt.lineWidth,
      eraserY - cxt.lineWidth,
      cxt.lineWidth * 2,
      cxt.lineWidth * 2
    );
    eraserFlag = 1;
  };
  //随着鼠标移动不停地擦出
  canvas.onmousemove = function(evt) {
    evt = window.event || evt;
    var eraserX = evt.pageX - this.offsetLeft;
    var eraserY = evt.pageY - this.offsetTop;
    // 擦除方法
    if (eraserFlag) {
      //判断鼠标左键是否按下(按下的情况下拖动鼠标才能删除)
      cxt.clearRect(
        eraserX - cxt.lineWidth,
        eraserY - cxt.lineWidth,
        cxt.lineWidth * 2,
        cxt.lineWidth * 2
      );
    }
  };
  //抬起鼠标按键 	清除擦出的状态位 变成0
  canvas.onmouseup = function() {
    eraserFlag = 0;
  };
  //抬起鼠标移出画布 	清除擦出的状态位 变成0
  canvas.onmouseout = function() {
    eraserFlag = 0;
  };
}

//油漆桶工具函数
function drawPaint(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function() {
    //把画布涂成指定的颜色->画一个填充颜色的矩形
    cxt.fillRect(0, 0, 880, 400);
  };
  canvas.onmouseup = null;
  canvas.onmousemove = null;
  canvas.onmouseout = null;
}

//吸管工具函数
function drawStraw(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    var strawX = evt.pageX - this.offsetLeft;
    var strawY = evt.pageY - this.offsetTop;
    //获取该点坐标处的颜色信息
    //获取图像信息的方法getImageData(开始点X,开始点Y,宽度,高度)
    var obj = cxt.getImageData(strawX, strawY, 1, 1);
    //alert(obj.data[3]);//ImageData对象
    //obj.data=[红,绿,蓝色,透明度]//1像素的数据
    //注意:在data数组中，每4个数组元素表示canvas画布中的一个像素点，
    //这4个元素的取值范围都是0-255
    /*obj.data=[
			红,绿,蓝色,透明度,
			红,绿,蓝色,透明度,
			红,绿,蓝色,透明度,
			红,绿,蓝色,透明度,
			红,绿,蓝色,透明度，
			红,绿,蓝色,透明度,
			红,绿,蓝色,透明度,
			红,绿,蓝色,透明度,
			]//多像素的数据
			
		*/

    //红色的RGB(255,0,0)
    //绿色的RGB(0,255,0);
    var color =
      "rgb(" + obj.data[0] + "," + obj.data[1] + "," + obj.data[2] + ")";
    //将吸管吸出的颜色设定到我们的应用中
    cxt.strokeStyle = color;
    cxt.fillStyle = color;
    //颜色吸取吸取之后自动选中画笔工具
    drawBrush(0);
  };
  //取消移动事件 、鼠标抬起事件、鼠标移出事件
  canvas.onmousemove = null;
  canvas.onmouseup = null;
  canvas.onmouseout = null;
}

//文本工具函数
function drawText(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    //获取鼠标点击时的位置
    var textX = evt.pageX - this.offsetLeft;
    var textY = evt.pageY - this.offsetTop;
    //alert(textX+'------'+textY);
    //获取用户输入的信息
    //window.prompt(对话框提示,默认值);
    var userVal = window.prompt("请在这里输入文字", "");
    //alert(userVal);
    //将用户输入的文字写到画布中对应的坐标点上。
    if (userVal != null) {
      cxt.fillText(userVal, textX, textY);
    }
  };
  canvas.onmousemove = null;
  canvas.onmouseup = null;
  canvas.onmouseout = null;
}

//放大镜工具函数
function drawMagnifier(num) {
  setStatus(actions, num, 1);
  //用户输入的数据大小
  var scale = window.prompt("请输入要放大的百分比[只能是整型]", "100");
  //吧数据转成对应canvas画布的大小
  var scaleW = (880 * scale) / 100;
  var scaleH = (400 * scale) / 100;
  //将数据设置到对应HTML标签上
  canvas.style.width = parseInt(scaleW) + "px";
  canvas.style.height = parseInt(scaleH) + "px";
}

//线形状函数
function drawLine(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    //获取起始点的坐标(相对于canvas画布的)
    //先获取鼠标距离页面顶端的距离和左端的距离
    //evt.pageY 	evt.pageX
    //获取当前画布相对页面顶端和左端的距离
    //this.offectTop 		this.offsetLeft

    //计算当前鼠标相对于canvas画布的距离(以canvas的左上角为0，0)
    var startX = evt.pageX - this.offsetLeft;
    var startY = evt.pageY - this.offsetTop;
    //设置直线的开始点
    cxt.beginPath(); //尽量写上开始新路径
    cxt.moveTo(startX, startY);
  };
  canvas.onmousemove = null; //注销掉其他工具注册时间
  canvas.onmouseout = null; //
  //鼠标按键抬起的时候
  canvas.onmouseup = function(evt) {
    //计算鼠标抬起时鼠标相对于画布的坐标
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    //设置路径吧开始点和结束点连接起来,然后进行绘图
    cxt.lineTo(endX, endY);
    cxt.closePath();
    cxt.stroke();
  };
}
//将变量设置为全局变量(如果是局部变量在其他的函数中无法调用)
var arcX = 0;
var arcY = 0;
//圆形形状函数
function drawArc(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    //获取圆心的位置
    arcX = evt.pageX - this.offsetLeft;
    arcY = evt.pageY - this.offsetTop;
  };

  canvas.onmouseup = function(evt) {
    evt = window.event || evt;
    //获取半径(目的)
    //实际获取的是一个坐标
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    //计算C的距离
    var a = endX - arcX;
    var b = endY - arcY;
    //计算半径
    var c = Math.sqrt(a * a + b * b);
    cxt.beginPath();
    cxt.arc(arcX, arcY, c, 0, 360, false);
    cxt.closePath();
    cxt.stroke();
  };
  canvas.onmousemove = null; //注销掉鼠标移动时间
  canvas.onmouseout = null;
}
//设置矩形全局变量
var rectX = 0;
var rectY = 0;
//矩形形状函数
function drawRect(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    //获取矩形左上角(对角线的开始点)
    rectX = evt.pageX - this.offsetLeft;
    rectY = evt.pageY - this.offsetTop;
  };

  canvas.onmouseup = function(evt) {
    evt = window.event || evt;
    //先获取鼠标的当前坐标
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    //计算矩形的宽高
    var rectW = endX - rectX;
    var rectH = endY - rectY;
    //画出矩形
    cxt.strokeRect(rectX, rectY, rectW, rectH);
  };
  canvas.onmousemove = null;
  canvas.onmouseout = null;
}

var polyX = 0;
var polyY = 0;
//多边形形状函数
function drawPoly(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    polyX = evt.pageX - this.offsetLeft;
    POLyY = evt.pageY - this.offsetTop;
  };
  canvas.onmouseup = function(evt) {
    evt = window.event || evt;
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    cxt.beginPath();
    //将画笔移动到右下角的顶点
    cxt.moveTo(endX, endY);
    //计算左下角的顶点坐标
    var lbX = 2 * polyX - endX;
    var lbY = endY;
    cxt.lineTo(lbX, lbY);
    //设置第三个顶点的坐标
    var tmpC = 2 * (endX - polyX);
    var tmpA = endX - polyX;
    var tmpB = Math.sqrt(tmpC * tmpC - tmpA * tmpA);
    //计算最上面顶点坐标
    //endY-tmpB 定点的Y坐标 polyX是顶点的X坐标
    //画到顶点
    cxt.lineTo(polyX, endY - tmpB);
    //封闭路径->画出来
    cxt.closePath();
    cxt.stroke();
  };
  canvas.onmousemove = null;
  canvas.onmouseout = null;
}

//圆形填充形状函数
function drawArcFill(num) {
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    //获取圆心的位置
    arcX = evt.pageX - this.offsetLeft;
    arcY = evt.pageY - this.offsetTop;
  };

  canvas.onmouseup = function(evt) {
    evt = window.event || evt;
    //获取半径(目的)
    //实际获取的是一个坐标
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    //计算C的距离
    var a = endX - arcX;
    var b = endY - arcY;
    //计算半径
    var c = Math.sqrt(a * a + b * b);
    cxt.beginPath();
    cxt.arc(arcX, arcY, c, 0, 360, false);
    cxt.closePath();
    cxt.fill();
  };
  canvas.onmousemove = null; //注销掉鼠标移动时间
  canvas.onmouseout = null;
}

//矩形填充形状函数
function drawRectFill(num) {
  setStatus(actions, num, 1);
  setStatus(actions, num, 1);
  canvas.onmousedown = function(evt) {
    evt = window.event || evt;
    //获取矩形左上角(对角线的开始点)
    rectX = evt.pageX - this.offsetLeft;
    rectY = evt.pageY - this.offsetTop;
  };

  canvas.onmouseup = function(evt) {
    evt = window.event || evt;
    //先获取鼠标的当前坐标
    var endX = evt.pageX - this.offsetLeft;
    var endY = evt.pageY - this.offsetTop;
    //计算矩形的宽高
    var rectW = endX - rectX;
    var rectH = endY - rectY;
    //画出矩形
    cxt.fillRect(rectX, rectY, rectW, rectH);
  };
  canvas.onmousemove = null;
  canvas.onmouseout = null;
}

//线宽设置函数
function setLineWidth(num) {
  setStatus(widths, num, 1);
  switch (num) {
    case 0:
      cxt.lineWidth = 1;
      break;
    case 1:
      cxt.lineWidth = 3;
      break;
    case 2:
      cxt.lineWidth = 5;
      break; //第14讲补充的break 原因:遗漏
    case 3:
      cxt.lineWidth = 8;
      break;
    default:
      cxt.lineWidth = 1;
  }
}

//颜色设置函数
function setColor(obj, num) {
  setStatus(colors, num, 0);
  //设置画笔颜色和填充颜色
  cxt.strokeStyle = obj.id;
  cxt.fillStyle = obj.id;
}
