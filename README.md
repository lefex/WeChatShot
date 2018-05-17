# 开发APP的另一扇窗--逆向

逆向是打开第三方 APP 的一扇窗，本项目主要总结利用逆向做的一些有意义的事情。

### 一、给微信添加聊天记录截图功能

[查看原理](https://github.com/lefex/WeChatShot/wiki/%E7%BB%99%E5%BE%AE%E4%BF%A1%E6%B7%BB%E5%8A%A0%E8%81%8A%E5%A4%A9%E8%AE%B0%E5%BD%95%E6%88%AA%E5%9B%BE%E5%8A%9F%E8%83%BD)

> 有时候，知识小集群里讨论的技术问题，比较有价值，我们会把有价值的内容整理出来供大家查阅。但为了保护群友隐私，需要把昵称和头像都打码，如果碰到几百条聊天记录，这样做简直要吐血。而且也不能截一张长图，只能一张一张截取，然后拼接起来。群聊记录只能在微信内分享，这也限制了传播的渠道。为了提高小集成员工作效率，想着能不能给微信做个插件，解决这些问题。我们一直在追求如何更有效率做我们的工作，比如使用脚本自动整理每周小集内容，使用微信小程序给读者更好阅读体验。（呀，还有脚本，如果你还不知道，那肯定没有点 star 吧，[传送门](https://github.com/iOS-Tips/iOS-tech-set/tree/master/script)）

![](https://github.com/lefex/WeChatShot/blob/master/images/xiaoguo.gif?raw=true)

[**了解更多微信项目**](https://github.com/lefex/iWeChat)

### 二、查看第三方APP使用的第三方库

> 有时候想研究某个竞品APP时，需要了解其使用的第三方库，使用 class-dump 导出的头文件非常多，刚靠肉眼查看时，耗时耗力。为了解决这个痛点，便发明了这个工具。下面是获取某个第三方 APP 使用的第三方库，可以查看 pod 库的 star 数，源地址。

- [AFNetworking](https://github.com/AFNetworking/AFNetworking.git) - (30982)
- [Masonry](https://github.com/cloudkite/Masonry.git) - (16318)
- [MJRefresh](https://github.com/CoderMJLee/MJRefresh.git) - (11823)
- [Mantle](https://github.com/github/Mantle.git) - (10984)
- [iCarousel](https://github.com/nicklockwood/iCarousel.git) - (10440)
- [CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket.git) - (9991)
- [YYText](https://github.com/ibireme/YYText.git) - (7245)
- [SWTableViewCell](https://github.com/CEWendel/SWTableViewCell.git) - (7041)
- [Reachability](https://github.com/tonymillion/Reachability.git) - (6626)
- [SSKeychain](https://github.com/soffes/sskeychain.git) - (4808)
- [NJKWebViewProgress](https://github.com/ninjinkun/NJKWebViewProgress.git) - (3863)
- [SSZipArchive](https://github.com/ZipArchive/ZipArchive.git) - (3443)
- [MMWormhole](https://github.com/mutualmobile/MMWormhole.git) - (3414)
- [HMSegmentedControl](https://github.com/HeshamMegid/HMSegmentedControl.git) - (3322)
- [YapDatabase](https://github.com/yaptv/YapDatabase.git) - (3046)
- [hpple](https://github.com/topfunky/hpple.git) - (2534)
- [TYAttributedLabel](https://github.com/12207480/TYAttributedLabel.git) - (2366)

#### 使用

本工具基于 python 写的，在[这里](https://github.com/lefex/WeChatShot/podlib/source)可以找到源码。下载源码后修改 `main.py` 文件的 `IPA_HEADER_PATH` 为 class-dump 导出的头文件目录。执行 `python main.py`

```
IPA_HEADER_PATH = '/Users/lefex/Desktop/header/xxx'
```


### 三、分类第三方 APP 头文件

> 利用 class-dump 导出的头文件，根据前缀整理成不同的文件夹。
 
#### 使用

本工具基于 python 写的，在[这里](https://github.com/lefex/WeChatShot/podlib/source)可以找到源码。下载源码后修改 `file_catagory.py ` 文件的 `IPA_HEADER_PATH` 为 class-dump 导出的头文件目录。执行 `python file_catagory.py `

```
IPA_HEADER_PATH = '/Users/lefex/Desktop/header/xxx'
```
