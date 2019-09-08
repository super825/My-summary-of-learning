[TOC]

## HTML5音/视频标签详解

### 音视频的发展史

> 早期：`<embed>`+`<object>`+文件

- 问题：不是所有浏览器都支持，而且embed不是标准。

> 现状：Realplay、window media、Quick Time 、Flash

- 问题：每个厂商每个标准，网站编码和格式也都不相同，flash的出现解决了面的问题，但是apple在07年决定任何设备将不再支持flash。

- HTML5认为浏览器应该原生支持音视频，因为他们现在也是web中的一等公民了！

### 视频格式的简单介绍

- 常见的视频格式
  - 视频的组成部分：画面、音频、编码格式
  - 视频编码：H.264、Theora、VP8(google开源)

- 常见的音频格式
  - 视频编码：ACC、MP3、Vorbis

### HTML5支持的格式

- HTML5能在完全脱离插件的情况下播放音视频，但是不是所有格式都支持。
  
- HTML5支持的视频格式：
  - Ogg = 带有Theora视频编码 + Vorbis音频编码的Ogg文件
    - 支持的浏览器: F、C、O
  - MEPG4 = 带有H.264视频编码 + AAC音频编码的MPEG4文件
    - 支持的浏览器: S、C
  - WebM = 带有VP8视频编码 + Vorbis音频编码的WebM格式  
    - 支持的浏览器: I、F、C、O

### `<Video>`的使用

```html
<video src="文件地址" controls="controls"></video>

<video src="文件地址" controls="controls">
  您的浏览器暂不支持video标签。播放视频
</video>

<video controls="controls" width="300">
  <source src="move.ogg" type="video/ogg" >
  <source src="move.mp4" type="video/mp4" >
  您的浏览器暂不支持video标签。播放视频
</video>
```

### Video的常见属性

| 属性       | 值         | 描述                                      |
| ---------- | ---------- | ----------------------------------------- |
| autoplay   | autoplay   | 视频就绪自动播放                          |
| controls   | controls   | 向用户显示播放控件                        |
| width      | pixels     | 设置播放器宽度                            |
| height     | pixels     | 设置播放器高度                            |
| loop       | loop       | 播放完是否继续播放该视频，循环播放        |
| preload    | preload    | 是否等加载完再播放                        |
| src        | url        | 视频url地址                               |
| poster     | imgurl     | 加载等待的画面图片                        |
| autobuffer | autobuffer | 设置为浏览器缓冲方式，不设置autoply才有效 |

### Video的API方法

| 方法        | 属性        | 事件     |
| ----------- | ----------- | -------- |
| play()      | currentSrc  | play     |
| pause()     | currentTime | pause    |
| load()      | videoWidth  | progress |
| canPlayType | videoHeight | error    |

|                              | 全屏                               | 退出全屏                           |
| :--------------------------- | :--------------------------------- | :--------------------------------- |
| webkit Safari5.1 /Chrome 15) | element.webkitRequestFullScreen(); | document.webkitCancelFullScreen(); |
| firefox (works in nightly)   | element.mozRequestFullScreen();    | document.mozCancelFullScreen();    |
| W3C suggestion               | element.requestFullscreen();       | document.exitFullscreen();         |

### Video的API属性

| 属性                | 说明                                           |
| ------------------- | ---------------------------------------------- |
| audioTracks         | 返回可用的音轨列表（MultipleTrackList对象）    |
| autoplay            | 媒体加载后自动播放                             |
| buffered            | 返回缓冲部件的时间范围(TimeRanges对象)         |
| controller          | 返回当前的媒体控制器（MediaController对象）    |
| controls            | 显示播控控件                                   |
| crossOrigin         | CORS设置                                       |
| currentSrc          | 返回当前媒体的URL                              |
| currentTime         | 当前播放的时间，单位秒 (快进快退10秒)          |
| defaultMuted        | 缺省是否静音                                   |
| defaultPlaybackRate | 播控的缺省倍速                                 |
| duration            | 返回媒体的播放总时长，单位秒                   |
| ended               | 返回当前播放是否结束标志                       |
| error               | 返回当前播放的错误状态                         |
| initialTime         | 返回初始播放的位置                             |
| loop                | 是否循环播放                                   |
| mediaGroup          | 当前音视频所属媒体组 (用来链接多个音视频标签)  |
| muted               | 是否静音                                       |
| networkState        | 返回当前网络状态                               |
| paused              | 是否暂停                                       |
| playbackRate        | 播放的倍速(加速、减速播放)                     |
| played              | 当前播放部件已经播放的时间范围(TimeRanges对象) |
| preload             | 页面加载时是否同时加载音视频                   |
| readyState          | 返回当前的准备状态                             |
| seekable            | 返回当前可跳转部件的时间范围(TimeRanges对象)   |
| seeking             | 返回用户是否做了跳转操作                       |
| src                 | 当前音视频源的URL                              |
| startOffsetTime     | 返回当前的时间偏移(Date对象)                   |
| textTracks          | 返回可用的文本轨迹(TextTrackList对象)          |
| videoTracks         | 返回可用的视频轨迹(VideoTrackList对象)         |
| volume              | 音量值                                         |

### Video的常用事件

| 事件           | 描述                                                             |
| -------------- | ---------------------------------------------------------------- |
| abort          | 当音视频加载被异常终止时产生该事件                               |
| canplay        | 当浏览器可以开始播放该音视频时产生该事件                         |
| canplaythrough | 当浏览器可以开始播放该音视频到结束而无需因缓冲而停止时产生该事件 |
| durationchange | 当媒体的总时长改变时产生该事件                                   |
| emptied        | 当前播放列表为空时产生该事件                                     |
| ended          | 当前播放列表结束时产生该事件                                     |
| error          | 当加载媒体发生错误时产生该事件                                   |
| loadeddata     | 当加载媒体数据时产生该事件                                       |
| loadedmetadata | 当收到总时长，分辨率和字轨等metadata时产生该事件                 |
| loadstart      | 当开始查找媒体数据时产生该事件                                   |
| pause          | 当媒体暂停时产生该事件                                           |
| play           | 当媒体播放时产生该事件                                           |
| playing        | 当媒体从因缓冲而引起的暂停和停止恢复到播放时产生该事件           |
| progress       | 当获取到媒体数据时产生该事件                                     |
| ratechange     | 当播放倍数改变时产生该事件                                       |
| seeked         | 当用户完成跳转时产生该事件                                       |
| seeking        | 当用户正执行跳转时操作的时候产生该事件                           |
| stalled        | 当试图获取媒体数据，但数据还不可用时产生该事件                   |
| suspend        | 当获取不到数据时产生该事件                                       |
| timeupdate     | 当前播放位置发生改变时产生该事件                                 |
| volumechange   | 当前音量发生改变时产生该事件                                     |
| waiting        | 当视频因缓冲下一帧而停止时产生该事件                             |

### HTML5支持的音频格式

- HTML5在不使用插件的情况下也可以原生的支持音频格式文件的播放，当然支持格式是有限的
- HTML5支持的音频格式：

```html
    Ogg       免费  支持的浏览器:C、F、O
    MP3       收费  支持的浏览器: I、C、S
    Wav       收费  支持的浏览器: F、O、S
```

### `<audio>`的使用

```html
<audio src="文件地址" controls="controls"></audio>

<audio src="文件地址" controls="controls">
  您的浏览器暂不支持audio标签。播放视频
</audio>

<audio controls="controls">
  <source src="happy.MP3" type="video/mpeg" >
  <source src="happy.ogg" type="video/ogg" >
  您的浏览器暂不支持audio标签。播放视频
</audio>
```

### audio的常见属性

| 属性     | 值       | 描述                                                                                      |
| -------- | -------- | ----------------------------------------------------------------------------------------- |
| autoplay | autoplay | 如果出现该属性，则音频在就绪后马上播放                                                    |
| controls | controls | 如果出现该属性，则向用户显示控件，比如播放按钮                                            |
| loop     | loop     | 如果出现该属性，则每当音频结束时重新开始播放                                              |
| preload  | preload  | 如果出现该属性，则音频在页面加载时进行加载，并预备播放，如果使用 "autoplay"，则忽略该属性 |
| src      | url      | 要播放的音频的 URL                                                                        |
