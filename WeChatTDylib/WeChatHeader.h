//
//  WeChatHeader.h
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/1/31.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const kScreenshotTitle = @"截图";
static NSString * const kScreenshotTitleMask = @"截图（马赛克）";
static NSString * const kScreenshotTitlePreview = @"预览";
static NSString * const kScreenshotLogoTitle = @"by公众号 知识小集";

@interface WeChatHeader : NSObject
+ (UIImage *)captureScrollView:(UIScrollView *)view;
+ (UIImage *)addWatemarkTextWithImage:(UIImage *)image text:(NSString *)text;
@end

@interface MMHeadImageView : UIView
- (void)updateUsrName:(id)arg1 withHeadImgUrl:(id)arg2;
- (NSString *)getRealUserName:(id)arg1;
@end

@interface WCActionSheet: UIWindow
@property(strong, nonatomic) NSMutableArray *buttonTitleList;
- (void)showInView:(id)arg1;
- (long long)addButtonWithItem:(id)arg1 atIndex:(unsigned long long)arg2;
- (long long)addButtonWithTitle:(id)arg1 atIndex:(unsigned long long)arg2;
- (long long)addButtonWithTitle:(id)arg1;
@end

@interface WCActionSheetItem: NSObject
@property(copy, nonatomic) NSString *title;
- (WCActionSheetItem *)initWithTitle:(id)arg1;
- (double)getItemHeight;
@end


@interface MMTableView: UITableView
@end

@interface FavRecordBaseNodeView: UIView
{
    UILabel *m_srcTitleLabel;
    //  MMUILongPressImageView *_headImageView;
    UIView *m_headImg;
}
@end

@interface FavBaseDetailViewController: UIViewController
{
    MMTableView *m_tableView;
}
- (UITableViewCell *)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;

@end

@interface FavRecordDetailViewController: FavBaseDetailViewController
{
    WCActionSheet *favImgLongPressAction;
}
- (void)viewWillDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
// WCActionSheetDelegate
- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(long long)arg2;
// 下面这两个协议没有实现，不然直接在这里添加菜单，多好，试着给这个类添加新的方法也不好使
- (void)didPresentActionSheet:(WCActionSheet *)arg1;
- (void)willPresentActionSheet:(WCActionSheet *)arg1;

@end

// 群聊记录
@interface MsgRecordDetailViewController: UIViewController
{
    MMTableView *m_tableView;
}
- (void)viewWillAppear:(_Bool)arg1;
- (void)viewWillDisappear:(_Bool)arg1;
- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(long long)arg2;;
- (UITableViewCell *)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
@end

