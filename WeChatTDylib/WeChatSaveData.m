//
//  WeChatSaveData.m
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/3/31.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import "WeChatSaveData.h"
#import "WeChatUser.h"
#import "WeChatUser.h"

@implementation WeChatSaveData

+ (instancetype)defaultSaveData
{
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userNameDict = [NSMutableDictionary dictionary];
    }
    return self;
}

@end


@implementation WeChatCapture

+ (void)saveCaptureImageWithSheet:(WCActionSheet *)sheet index:(NSInteger)index viewController:(UIViewController *)viewController
{
    WCActionSheetItem *item = sheet.buttonTitleList[index];
    if([item.title isEqualToString:kScreenshotTitleMask]){
        [WeChatSaveData defaultSaveData].maskType = WeChatSaveDataMaskTypeMast;
        [self saveImageWithViewController:viewController];
    } else if ([item.title isEqualToString:kScreenshotTitle]){
        [WeChatSaveData defaultSaveData].maskType = WeChatSaveDataMaskTypeNoMask;
        [self saveImageWithViewController:viewController];
    } else if ([item.title isEqualToString:kScreenshotTitlePreview]){
        [WeChatSaveData defaultSaveData].maskType = WeChatSaveDataMaskTypePreview;
        MMTableView *tableView = [viewController valueForKeyPath:@"m_tableView"];
        [tableView reloadData];
        [WeChatUser resetIndex];
    } else {
        [WeChatSaveData defaultSaveData].maskType = WeChatSaveDataMaskTypeNoSet;
    }
}

+ (void)saveImageWithViewController:(UIViewController *)viewController
{
    MMTableView *tableView = [viewController valueForKeyPath:@"m_tableView"];
    [tableView reloadData];
    dispatch_after(2, dispatch_get_main_queue(), ^{
        UIImage *image = [WeChatHeader captureScrollView:tableView];
        if(image) {
            UIImage *reImage = [WeChatHeader addWatemarkTextWithImage:image text:kScreenshotLogoTitle];
            UIImageWriteToSavedPhotosAlbum(reImage, nil, nil, 0);
        }
        [WeChatUser resetIndex];
    });
}

+ (void)updateCellDataWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if ([WeChatSaveData defaultSaveData].maskType == WeChatSaveDataMaskTypeMast || [WeChatSaveData defaultSaveData].maskType == WeChatSaveDataMaskTypePreview) {
        NSArray *subviews = [cell.contentView subviews];
        FavRecordBaseNodeView *nodeView = [subviews lastObject];
        if ([NSStringFromClass([nodeView class]) hasSuffix:@"NodeView"]) {
            UILabel *nickNameLabel = [nodeView valueForKey:@"m_srcTitleLabel"];
            if (nickNameLabel) {
                CGRect tempFrame = nickNameLabel.frame;
                tempFrame.size.width = 120;
                nickNameLabel.frame = tempFrame;
            }
            
            MMHeadImageView *imageView = [nodeView valueForKeyPath:@"m_headImg"];
            NSString *nickName = [imageView valueForKey:@"_nsUsrName"];
            WeChatUser *aUser = [[WeChatSaveData defaultSaveData].userNameDict objectForKey:nickName?:@""];
            if (!aUser) {
                aUser = [WeChatUser user];
                [[WeChatSaveData defaultSaveData].userNameDict setObject:aUser forKey:nickName?:@""];
            }
            nickNameLabel.text = aUser.nickname ?: @"";
            if (imageView) {
                [imageView updateUsrName:aUser.nickname withHeadImgUrl:aUser.icon];
            }
        }
    }
}

+ (void)viewWillDisappearAction
{
    [WeChatSaveData defaultSaveData].isNeedAddMenu = NO;
    [WeChatSaveData defaultSaveData].maskType = WeChatSaveDataMaskTypeNoSet;
    [[WeChatSaveData defaultSaveData].userNameDict removeAllObjects];
}

+ (void)viewWillAppearAction
{
    [WeChatSaveData defaultSaveData].isNeedAddMenu = YES;
    [WeChatSaveData defaultSaveData].maskType = WeChatSaveDataMaskTypeNoSet;
}

@end

