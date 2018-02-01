//
//  WeChatSaveData.m
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/3/31.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import "WeChatSaveData.h"

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
    });
}

+ (void)updateCellDataWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if ([WeChatSaveData defaultSaveData].maskType == WeChatSaveDataMaskTypeMast) {
        NSArray *subviews = [cell.contentView subviews];
        FavRecordBaseNodeView *nodeView = [subviews lastObject];
        if ([NSStringFromClass([nodeView class]) hasSuffix:@"NodeView"]) {
            UILabel *nickNameLabel = [nodeView valueForKey:@"m_srcTitleLabel"];
            if (nickNameLabel) {
                CGRect tempFrame = nickNameLabel.frame;
                tempFrame.size.width = 120;
                nickNameLabel.frame = tempFrame;
                NSString *nickName = nickNameLabel.text;
                NSString *dictNickName = [[WeChatSaveData defaultSaveData].userNameDict objectForKey:nickName?:@""];
                if (dictNickName) {
                    nickNameLabel.text = dictNickName;
                } else {
                    NSString *tempName = [NSString stringWithFormat:@"TS_%@", @(indexPath.row)];
                    [[WeChatSaveData defaultSaveData].userNameDict setObject:tempName forKey:nickName?:@""];
                    nickNameLabel.text = tempName;
                }
            }
            UIImageView *imageView = [nodeView valueForKeyPath:@"m_headImg._headImageView"];
            if (imageView) {
                imageView.image = [UIImage imageNamed:@"teachset.jpg"];
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
