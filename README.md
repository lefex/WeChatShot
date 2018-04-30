# 开发APP的另一扇窗--逆向

### 给微信添加聊天记录截图功能

> 有时候，知识小集群里讨论的技术问题，比较有价值，我们会把有价值的内容整理出来供大家查阅。但为了保护群友隐私，需要把昵称和头像都打码，如果碰到几百条聊天记录，这样做简直要吐血。而且也不能截一张长图，只能一张一张截取，然后拼接起来。群聊记录只能在微信内分享，这也限制了传播的渠道。为了提高小集成员工作效率，想着能不能给微信做个插件，解决这些问题。我们一直在追求如何更有效率做我们的工作，比如使用脚本自动整理每周小集内容，使用微信小程序给读者更好阅读体验。（呀，还有脚本，如果你还不知道，那肯定没有点 star 吧，[传送门](https://github.com/iOS-Tips/iOS-tech-set/tree/master/script)）

![](https://github.com/lefex/WeChatShot/blob/master/images/xiaoguo.gif?raw=true)

[查看原理](https://github.com/lefex/WeChatShot/wiki/%E7%BB%99%E5%BE%AE%E4%BF%A1%E6%B7%BB%E5%8A%A0%E8%81%8A%E5%A4%A9%E8%AE%B0%E5%BD%95%E6%88%AA%E5%9B%BE%E5%8A%9F%E8%83%BD)


### 查看第三方APP使用的第三方库

有时候想研究某个竞品APP时，需要了解其使用的第三方库，使用 class-dump 导出的头文件非常多，刚靠肉眼查看时，耗时耗力。为了解决这个痛点，便发明了这个工具。下面是获取某个第三方 APP 使用的第三方库，可以查看 pod 库的 star 数，源地址。

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
- [MarqueeLabel](https://github.com/cbpowell/MarqueeLabel.git) - (2274)
- [HPGrowingTextView](https://github.com/HansPinckaers/GrowingTextView.git) - (2052)
- [OpenUDID](https://github.com/ylechelle/OpenUDID.git) - (1909)
- [MBProgressHUD](https://github.com/matej/MBProgressHUD.git) - (1789)
- [YYCache](https://github.com/ibireme/YYCache.git) - (1734)
- [QBImagePickerController](https://github.com/questbeat/QBImagePickerController.git) - (1687)
- [Watchdog](https://github.com/wojteklukaszuk/Watchdog.git) - (1505)
- [WeiboSDK](https://github.com/sinaweibosdk/weibo_ios_sdk.git) - (1257)
- [UIAlertView-Blocks](https://github.com/jivadevoe/UIAlertView-Blocks.git) - (907)
- [FCFileManager](https://github.com/fabiocaccamo/FCFileManager.git) - (780)
- [ZipArchive](https://github.com/mattconnolly/ZipArchive.git) - (779)
- [SloppySwiper](https://github.com/fastred/SloppySwiper.git) - (744)
- [YBPopupMenu](https://github.com/lyb5834/YBPopupMenu.git) - (491)
- [RMUniversalAlert](https://github.com/ryanmaxwell/RMUniversalAlert.git) - (267)
- [LMMediaPlayer](https://github.com/0x0c/LMMediaPlayer.git) - (181)
- [XMSegmentedControl](https://github.com/xaviermerino/XMSegmentedControl.git) - (145)
- [AFImageDownloader](https://github.com/ashfurrow/AFImageDownloader.git) - (89)
- [Bugtags](https://github.com/bugtags/Bugtags-iOS.git) - (88)
- [XMPlayer](https://github.com/inmine/XMPlayer.git) - (38)
- [UIActionSheet-Blocks](https://github.com/freak4pc/UIActionSheet-Blocks.git) - (19)
- [JKAlert](https://github.com/shaojiankui/JKAlert.git) - (6)
- [TFHpple](https://github.com/tpctt/TFHpple.git) - (3)
- [XMImagePickerController](https://github.com/Mazy-ma/XMImagePickerController.git) - (2)
- [M3U8Parser](https://github.com/Jignesh1805/M3U8Parser.git) - (1)

**缺点**

- 只能查看 cocoapod 中的第三方库，也就是说如果某个第三方库不支持 pod，这个工具不能查到；
- 某个第三方库的名字和项目中的名字一样，可能会把不是第三方库的识别为第三方库；
- 完善 `source_file` 提高识别率
