//
//  WeChatSaveData.h
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/3/31.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeChatHeader.h"


typedef NS_ENUM(NSUInteger, WeChatSaveDataMaskType) {
    WeChatSaveDataMaskTypeNoSet,
    WeChatSaveDataMaskTypeNoMask,
    WeChatSaveDataMaskTypeMast,
};

@interface WeChatSaveData : NSObject

+ (instancetype)defaultSaveData;

@property (nonatomic, assign) WeChatSaveDataMaskType maskType;
@property (nonatomic, strong) NSMutableDictionary *userNameDict;
@property (nonatomic, assign) BOOL isNeedAddMenu;

@end


@interface WeChatCapture : NSObject

+ (void)saveCaptureImageWithSheet:(WCActionSheet *)sheet index:(NSInteger)index viewController:(UIViewController *)viewController;
+ (void)updateCellDataWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
+ (void)viewWillDisappearAction;
+ (void)viewWillAppearAction;

@end
