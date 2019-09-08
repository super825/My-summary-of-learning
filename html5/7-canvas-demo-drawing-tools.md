[TOC]

## Canvas 实例 3-在线画图板

### 本章概要

- 画图板功能分析
- 画图板技术分析
- 绘制页面、美化页面
- 编辑功能。先画一个简单的画图板分析思路，然后应用到项目中

### 画图板功能分析

- 功能区(保存、清空)
- 工具区(形状和工具)
- 属性设置区(颜色和线宽)
- 绘图区域(canvas 标签)

### 技术需求分析

- 页面布局->HTML5 标签
- 页面美化->CSS2
- 功能设置->Javascript 编程
- Canvas API->属性设置、画线、写字、画图、画布操作(清空、获取画布信息)、
- 下载->php 的下载(JS 无法操作本地文件)

### 画一个简单的画布

- 鼠标点击时
  - 准备起始点 moveTo()、设置标志位
- 鼠标移动时
  - 判断标志位，值为 true 画图，false 不画图
  - 移动时指定路径 lineTo()，并且画出来 stroke()
- 鼠标离开或者抬
  - 清空标志位

### 复杂的在线画板

- 获取相应元素对象
- 设置点击状态
- 设置触发功能
  - 颜色属性设置
  - 线宽属性设置
  - 绘图形状设置
  - 工具指定

## 一个不为人知的协议 data URI 协议

### Data URI 协议格式

- 协议格式:

```js
data: 资源类型;
编码, 内容;
```

- 在浏览器中生成一个简单的 HTML 页面

```js
data:text/html;ascii,你好呀，亲 O(∩_∩)O
```

- 在浏览器中显示一个小图片(黑色 8x8 像素)

```js
data: image / bmp;
base64,
  Qk1eAAAAAAAAAD4AAAAoAAAACAAAAAgAAAABAAEAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP; ///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==
```

### Data URI 协议存在的问题

- base64 编码会增大 1/3 体积，占用更多带宽。
- 浏览器解析时，会消耗更多的 CPU 资源，并可能占用更多内存。（这个和浏览器的实现有关，不过至少得多一次 base64 解码。）
- 无法让浏览器缓存图像，只能缓存引用它的文件。
- 在 HTML 上不能复用，要复用只能放在 CSS 和 JavaScript 里。
- 如果把背景图片写在 CSS 或 JavaScript 里，在下载完 CSS 和 JavaScript 之前，浏览器是完全停止解析和渲染的，而常规的引用外部图片的方式是可以并行下载的。

### 结论

- 可以使用 data URI 形式来获取我们的图像数据。虽然他不一定好用，但是确实有值得我们利用的地方。
