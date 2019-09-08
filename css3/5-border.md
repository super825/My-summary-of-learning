[TOC]

## CSS3的新增边框属性

### 本章内容

- CSS1&2中的边框属性(W3C标准)
- CSS3 新增的边框属性
- CSS3 新增属性实例

### CSS1&2中的边框属性

| 属性                | 版本 | 简介                         |
| ------------------- | ---- | ---------------------------- |
| border              | CSS1 | 复合属性。设置对象边框的特性 |
| border-width        | CSS1 | 设置或检索对象边框宽度       |
| border-style        | CSS1 | 设置或检索对象边框样式       |
| border-color        | CSS1 | 设置或检索对象边框颜色       |
| border-top          | CSS1 | 复合属性。设置对象顶边的特性 |
| border-top-width    | CSS1 | 设置或检索对象顶边宽度       |
| border-top-style    | CSS1 | 设置或检索对象顶边样式       |
| border-top-color    | CSS1 | 设置或检索对象顶边颜色       |
| border-right        | CSS1 | 复合属性。设置对象右边的特性 |
| border-right-width  | CSS1 | 设置或检索对象右边宽度       |
| border-right-style  | CSS1 | 设置或检索对象右边样式       |
| border-right-color  | CSS1 | 设置或检索对象右边颜色       |
| border-bottom       | CSS1 | 复合属性。设置对象底边的特性 |
| border-bottom-width | CSS1 | 设置或检索对象底边宽度       |
| border-bottom-style | CSS1 | 设置或检索对象底边样式       |
| border-bottom-color | CSS1 | 设置或检索对象底边颜色       |
| border-left         | CSS1 | 复合属性。置对象左边的特性   |
| border-left-width   | CSS1 | 设置或检索对象左边宽度       |
| border-left-style   | CSS1 | 设置或检索对象左边样式       |
| border-left-color   | CSS1 | 设置或检索对象左边颜色       |

### CSS3 新增的边框属性

| 属性                       | 版本 | 简介                                                 |
| -------------------------- | ---- | ---------------------------------------------------- |
| border-image               | CSS3 | 设置或检索对象的边框使用图像来填充                   |
| border-image-source        | CSS3 | 设置或检索对象的边框是否用图像定义样式或图像来源路径 |
| border-image-slice         | CSS3 | 设置或检索对象的边框背景图的分割方式                 |
| border-image-width         | CSS3 | 设置或检索对象的边框厚度                             |
| border-image-outset        | CSS3 | 设置或检索对象的边框背景图的扩展                     |
| border-image-repeat        | CSS3 | 设置或检索对象的边框图像的平铺方式                   |
| border-radius              | CSS3 | 设置或检索对象使用圆角边框                           |
| border-top-left-radius     | CSS3 | 设置或检索对象左上角圆角边框                         |
| border-top-right-radius    | CSS3 | 设置或检索对象右上角圆角边框                         |
| border-bottom-right-radius | CSS3 | 设置或检索对象右下角圆角边框                         |
| border-bottom-left-radius  | CSS3 | 设置或检索对象左下角圆角边框                         |
| box-shadow                 | CSS3 | 设置或检索对象阴影                                   |
| box-reflect                | CSS3 | 设置或检索对象的倒影                                 |

### border-image属性

- CSS3中新增的边框属性，扩充了原盒子模型的功能，使得边框具备背景图片属性。
此前，border仅仅具备宽度、颜色和风格属性.
- 实现边框背景图片属性，通常使用padding和background属性进行模拟，但是这样就为设置盒子的背景增加了难度

### border-image语法

语法格式：该语法为CSS缩写样式
```
border-image：
	[border-image-source 图片来源 ] 
	[ border-image-slice分割方法 ]
	[ 	
		/ [ border-image-width边框宽度 ]? | 
		/ [border-image-outset 扩展方式 ] 
	] 
	[ border-image-repeat重复方式 ]
```

### border-image-source 语法

**说明：**
- 设置或检索对象的边框样式使用图像路径。 
- 指定一个图像用来替代border-style边框样式的属性。当border-image为none或图像不可见时，将会显示border-style所定义的边框样式效果。 
- 对应的脚本特性为borderImageSource。 

**取值：**
- none： 无背景图片。取值：
- none： 无背景图片。 
- `<url>`： 使用绝对或相对地址指定图像。 
- `<url>`： 使用绝对或相对地址指定图像。

### border-image-slice语法

**说明：**
- 设置或检索对象的边框背景图的分割方式。 
- 该属性指定从上，右，下，左方位来分隔图像，将图像分成4个角，4条边和中间区域共9份，中间区域始终是透明的（即没图像填充），除非加上关键字 fill。 
- 对应的脚本特性为borderImageSlice。 

**取值：**
- `<number>`： 用浮点数指定宽度。不允许负值。 
- `<%>`： 用百分比指定宽度。不允许负值。

### border-image-width语法

**说明：**
- 设置或检索对象的边框厚度。 
- 该属性用于指定使用多厚的边框来承载被裁剪后的图像。 
- 该属性可省略，由外部的border-width来定义。 
- 对应的脚本特性为borderImageWidth。 

**取值：**
- `<length>`： 用长度值指定宽度。不允许负值。 
- `<percentage>`： 用百分比指定宽度。不允许负值。 
- `<number>`： 用浮点数指定宽度。不允许负值。 
- auto： 如果auto值被设置，则border-image-width采用与border-image-slice相同的值。 

*注意:该值得大小不会累加到盒子模型之上，chrome会有3像素的大小，其余浏览器border的大小依然为0*

### border-image-outset语法

**说明：**
- 设置或检索对象的边框背景图的扩展。 
- 该属性用于指定边框图像向外扩展所定义的数值，即如果值为10px，则图像在原本的基础上往外延展10px再显示。 
- 对应的脚本特性为borderImageOutset。

**取值：**
- `<length>`： 用长度值指定宽度。不允许负值。 
- `<number>`： 用浮点数指定宽度。不允许负值。

### border-image-repeat语法

**说明：**
- 设置或检索对象的边框图像的平铺方式。 
- 该属性用于指定边框背景图的填充方式。可定义0-2个参数值，即水平和垂直方向。如果2个值相同，可合并成1个，表示水平和垂直方向都用相同的方式填充边框背景图；如果2个值都为stretch，则可省略不写。 
- 对应的脚本特性为borderImageOutset。 

**取值：**
- stretch： 指定用拉伸方式来填充边框背景图。 
- repeat： 指定用平铺方式来填充边框背景图。当图片碰到边界时，如果超过则被截断。 
- round： 指定用平铺方式来填充边框背景图。图片会根据边框的尺寸动态调整图片的大小直至正好可以铺满整个边框。写本文档时仅Firefox能看到该效果 
- space： 指定用平铺方式来填充边框背景图。图片会根据边框的尺寸动态调整图片的之间的间距直至正好可以铺满整个边框。写本文档时尚无浏览器能看到该效果  

### border-radius属性

**说明：**
- 设置或检索对象使用圆角边框。提供2个参数，2个参数以“/”分隔，每个参数允许设置1~4个参数值，第1个参数表示水平半径，第2个参数表示垂直半径，如第2个参数省略，则默认等于第1个参数 
水平半径：
- 如果提供四个参数值，将按上左、上右、下右、下左的顺序作用于四个角。 
- 如果提供一个，将用于全部的于四个角。 
- 如果提供两个，第一个用于上左、下右，第二个用于上右、下左。 
- 如果提供三个，第一个用于上左，第二个用于上右、下左，第三个用于下右。 
- 垂直半径也遵循以上4点。 
- 对应的脚本特性为borderRadius。 

**取值：**
- `<length>`： 用长度值设置对象的圆角半径长度。不允许负值 
- `<percentage>`： 用百分比设置对象的圆角半径长度。不允许负值 

### border-top-left-radius属性

**说明：**
- 设置或检索对象的左上角圆角边框。
- 如设置border-top-left-radius:5px 10px;
- 表示top-left这个角的水平圆角半径为5px，垂直圆角半径为10px。 
- 对应的脚本特性为borderTopLeftRadius。  

**取值：**
- `<length>`： 用长度值设置对象的圆角半径长度。不允许负值 
- `<percentage>`： 用百分比设置对象的圆角半径长度。不允许负值 

### border-top-right-radius属性

**说明：**
- 设置或检索对象的右上角圆角边框。
- 如设置border-top-right-radius:5px 10px;
- 表示top-right这个角的水平圆角半径为5px，垂直圆角半径为10px。 
- 对应的脚本特性为borderTopRightRadius。 

**取值：**
- `<length>`： 用长度值设置对象的圆角半径长度。不允许负值 
- `<percentage>`： 用百分比设置对象的圆角半径长度。不允许负值

### border-bottom-right-radius属性

**说明：**
- 设置或检索对象的左下角圆角边框
- 如设置border-bottom-right-radius:5px 10px;
- 表示bottom-right这个角的水平圆角半径为5px，垂直圆角半径为10px。 
- 对应的脚本特性为borderBottomRightRadius

**取值：**
- `<length>`： 用长度值设置对象的圆角半径长度。不允许负值 
- `<percentage>`： 用百分比设置对象的圆角半径长度。不允许负值

### border-bottom-left-radius属性

**说明：**
- 设置或检索对象的左下角圆角边框。 
- 如设置border-bottom-left-radius:5px 10px;
- 表示bottom-left这个角的水平圆角半径为5px，垂直圆角半径为10px。 
- 对应的脚本特性为borderBottomLeftRadius。 

**取值：**
- `<length>`： 用长度值设置对象的圆角半径长度。不允许负值 
- `<percentage>`： 用百分比设置对象的圆角半径长度。不允许负值

### box-shadow属性

**说明：**
- 设置或检索对象阴影。参阅text-shadow属性 
- 可以设定多组效果，每组参数值以逗号分隔。 
- 对应的脚本特性为boxShadow。 

**取值：**
- none： 无阴影 
- `<length>`①： 第1个长度值用来设置对象的阴影水平偏移值。可以为负值 
- `<length>`②： 第2个长度值用来设置对象的阴影垂直偏移值。可以为负值 
- `<length>`③： 如果提供了第3个长度值则用来设置对象的阴影模糊值。 
- `<length>`④： 如果提供了第4个长度值则用来设置对象的阴影外延值。 
- `<color>`： 设置对象的阴影的颜色。 
- inset： 设置对象的阴影类型为内阴影。该值为空时，则对象的阴影类型为外阴影 

### box-reflect属性

**说明：**

- 盒子倒影属性:可以对盒子模型进行倒影设置。

- 格式:
    -  1.none 
	-  2.位置 偏移? 水印图片?

**取值：**

- 位置： above(上)、below(下)、left(左)、right(右)
- 偏移： 用长度值来定义倒影与对象之间的间隔。可以为负值
- 水印图片: 设置倒影使用的图片或者渐变，默认为原内容

*注意:该属性目前仅webkit内核浏览器(chrome/safari/猎豹等)支持*
