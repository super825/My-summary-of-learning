[TOC]

## 创建易用的Web表单

### 便于排版的From表单

- XHTML或者HTML4.01中from和其中的表单标签(input、textarea、select、button)必须嵌套使用

```html
<form action="" method="post">
  <input  type="text" name="user" />
  <select name="year">
    <option value="1999"></option>
  </select>
  <textarea name="ext" ></textarea>
  <button type="submit">提交</button>
</form>
```

- HTML5中为了方便排版，可以使from中的表单标签脱离from的嵌套。方法:from指定ID，所有表单标签均添加from=id属性

```html
<form action="" method="post" id="register" >
</form>

<input  type="text" name="user" form="register" />
<select name="year" form="register" >
    <option value="1999"></option>
</select>
<textarea name="ext" form="register" ></textarea>
<button type="submit" form="register" >提交</button>
```

### 智能表单的使用和规范

| Input表单的type新属性值 | 描述                                         |
| ----------------------- | -------------------------------------------- |
| type="email"            | 限制用户输入必须为Email类型                  |
| type="url"              | 限制用户输入必须为URL类型                    |
| type="date"             | 限制用户输入必须为日期类型                   |
| type="time"             | 限制用户输入必须为时间类型O                  |
| type="month"            | 限制用户输入必须为月类型O                    |
| type="week"             | 限制用户输入必须为周类型O                    |
| type="number"           | 限制用户输入必须为数字类型                   |
| type="range"            | 产生一个滑动条的表单                         |
| type="search"           | 产生一个搜索意义的表单 配合results="n"属性 C |
| type="color"            | 生成一个颜色选择表单                         |

### 新增的表单属性

| 属性        | 值         | 说明                                         |
| ----------- | ---------- | -------------------------------------------- |
| required    | required   | 表单拥有该属性表示其内容不能为空，必填       |
| placeholder | 提示文本   | 表单的提示信息，存在默认值将不显示           |
| autofocus   | autofocus  | 自动聚焦属性，页面加载完成自动聚焦到指定表单 |
| pattern     | 正则表达式 | 输入的内容必须匹配到指定正则                 |

### Autocomplete列表

- Datalist标签配合option标签实现的自动填充表单功能：

```html
<input type="search" name="movie" list="search" >

<datalist id="search" >
  <option>火星救援</option>
  <option>星际穿越</option>
  <option>平行时空</option>
</datalist>
```

### output的使用

```html
<form oninput="res.value=no1.value*no2.value" >
  <input type="text" name="no1">
  <input type="text" name="no2">
  <output name="res"></output>
</form>
```
