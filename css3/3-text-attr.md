[TOC]

## CSS3的新增文本属性

### 本章内容

- CSS1&2中的文本属性(W3C标准)
- CSS3 新增的文本属性
- CSS3文本属性实例

### CSS1&2中的文本属性

| 属性           | 版本      | 简介                                                                  |
| -------------- | --------- | --------------------------------------------------------------------- |
| text-indent    | CSS1      | 检索或设置对象中的文本的缩进                                          |
| letter-spacing | CSS1      | 检索或设置对象中的文字之间的间隔                                      |
| word-spacing   | CSS1      | 检索或设置对象中的单词之间插入的空格数。                              |
| vertical-align | CSS1/CSS2 | 设置或检索对象内容的垂直对其方式                                      |
| white-space    | CSS1      | 设置或检索对象内空格的处理方式                                        |
| direction      | CSS2      | 检索或设置文本流的方向                                                |
| unicode-bidi   | CSS2      | 用于同一个页面里存在从不同方向读进的文本显示。与direction属性一起使用 |
| line-height    | CSS1      | 检索或设置对象的行高。即字体最底端与字体内部顶端之间的距离            |

### CSS3 新增的文本属性

| 属性                  | 版本      | 简介                                                      |
| --------------------- | --------- | --------------------------------------------------------- |
| text-overflow         | CSS3      | 设置或检索是否使用一个省略标记（...）标示对象内文本的溢出 |
| text-align            | CSS1/CSS3 | 设置或检索对象中文本的对齐方式                            |
| text-transform        | CSS1/CSS3 | 检索或设置对象中的文本的大小写                            |
| text-decoration       | CSS1/CSS3 | 复合属性。检索或设置对象中的文本的装饰，如下划线、闪烁等  |
| text-decoration-line  | CSS3      | 检索或设置对象中的文本装饰线条的位置。                    |
| text-decoration-color | CSS3      | 检索或设置对象中的文本装饰线条的颜色。                    |
| text-decoration-style | CSS3      | 检索或设置对象中的文本装饰线条的形状。                    |
| text-shadow           | CSS3      | 设置或检索对象中文本的文字是否有阴影及模糊效果            |
| text-fill-color       | CSS3      | 设置或检索对象中的文字填充颜色                            |
| text-stroke           | CSS3      | 复合属性。设置或检索对象中的文字的描边                    |
| text-stroke-width     | CSS3      | 设置或检索对象中的文字的描边厚度                          |
| text-stroke-color     | CSS3      | 设置或检索对象中的文字的描边颜色                          |
| tab-size              | CSS3      | 检索或设置对象中的制表符的长度                            |
| word-wrap             | CSS3      | 设置或检索当当前行超过指定容器的边界时是否断开转行        |

### text-overflow属性

- 作用：设定内容溢出状态下的文本处理方式。
- 取值：
  - clip： 默认值
    - 当对象内文本溢出时不显示省略标记（...），而是将溢出的部分裁切掉
  - ellipsis：
    - 当对象内文本溢出时显示省略标记（...）

- ***注意:该属性需要和over-flow:hidden属性(超出处理)还有white-space:nowrap(禁止换行)配合使用，否则无法看到效果***

### text-align属性

- 作用：设定文本对齐方式
- 取值：
  - left ：默认值 内容左对齐。
  - center：内容居中对齐。
  - right： 内容右对齐。
  - justify： 内容两端对齐。写本文档时仅Firefox能看到正确效果
  - start： 内容对齐开始边界。（CSS3）
  - end： 内容对齐结束边界。（CSS3）

### text-transform属性

- 作用：设定文本的大小写等形式的转换
- 取值：
  - none：默认值 无转换
  - capitalize：将每个单词的第一个字母转换成大写
  - uppercase：转换成大写
  - lowercase：转换成小写
  - full-width：将左右字符设为全角形式（CSS3）不支持
  - full-size-kana：将所有小假名字符转换为普通假名（CSS3）不支持，例如：土耳其语

### text-decoration属性

- 作用：设定文本修饰线。
- 取值：
  - [ text-decoration-line ]：不支持
    - 指定文本装饰的种类。相当于CSS1时的text-decoration属性
  - [ text-decoration-style ]：不支持
    - 指定文本装饰的样式。
  - [ text-decoration-color]：不支持
    - 指定文本装饰的颜色。
  - blink： 指定文字的装饰是闪烁。  仅opera和firefox
- 例如：
  - `text-decoration：overline`   CSS1实例
  - `text-decoration：#F00 double overline`   CSS3实例
- ***备注：目前主要浏览器都没有实现上述属性，但是依然可以使用CSS1的实例方式***

### text-decoration-line属性

- 作用：设定文本修饰线的位置。
- 取值：
  - none：默认值
    - 指定文字无装饰
  - underline：
    - 指定文字的装饰是下划线
  - overline：
    - 指定文字的装饰是上划线
  - line-through：
    - 指定文字的装饰是贯穿线
- ***备注:目前大部分浏览器未实现该属性。***

### text-decoration-color属性

- 作用：设定文本修饰线的颜色
- 取值：指定颜色

### text-decoration-style属性

- 作用：设定文本修饰线的样式。
- 取值：
  - solid：默认值
    - 实线
  - double：
    - 双线
  - dotted：
    - 点状线条
  - dashed：
    - 虚线
  - wavy：
    - 波浪线
- ***备注:目前大部分浏览器未实现该属性***

### text-shadow属性

- 作用：设定文本的阴影效果
- 取值：
  - none：默认值
    - 无阴影
  - `<length>`
    - ①： 第1个长度值用来设置对象的阴影水平偏移值。可以为负值
  - `<length>`
    - ②： 第2个长度值用来设置对象的阴影垂直偏移值。可以为负值
  - `<length>`
    - ③： 如果提供了第3个长度值则用来设置对象的阴影模糊值。不允许负值 0：不模糊，10px：模糊程度10像素
  - `<color>`
    - 设置对象的阴影的颜色

### text-fill-color属性

- 作用：文本填充颜色，指定文字填充部分的颜色
- 取值：颜色

### text-stroke属性

- 作用：文本边框颜色，指定文字描边部分的颜色
- 取值 :
  - [ text-stroke-width ]：
    - 设置或检索对象中的文字的描边厚度
  - [ text-stroke-color ]：
    - 设置或检索对象中的文字的描边颜色

### text-stroke-width属性

- 作用：指定文字描边部分的宽度，text-stroke的派生属性
- 取值：长度

### text-stroke-color属性

- 作用：指定文字描边部分的颜色，text-stroke的派生属性
- 取值：颜色

### tab-size属性

- 作用：设定一个tab缩进键，在页面中的显示长度。
- 取值：默认值：`８`
  - 长度或者整数值
  - 整数值：`z-index:1`  此处的1就是整数值，不需要单位，类似倍数。
  - 长度： `margin:10px` 此处的10px是长度值。

- ***注意:该属性只在`<pre>`标签之内(预格式化状态)显示才会有效。因为浏览器会自动忽略空白字符。opera和火狐浏览器需要使用浏览器私有前缀。***

### word-wrap属性

- 作用:溢出文本(特指类英文文字)的处理方式。
- 取值:
  - normal： 默认值
    - 允许内容顶开或溢出指定的容器边界。
  - break-word：
    - 内容将在边界内换行。如果需要，单词内部允许断行。
