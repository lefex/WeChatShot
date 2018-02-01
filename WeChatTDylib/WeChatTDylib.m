//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  WeChatTDylib.m
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/3/31.
//  Copyright (c) 2018年 Wang,Suyan. All rights reserved.
//

#import "WeChatTDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import "WeChatHeader.h"
#import "WeChatSaveData.h"

static __attribute__((constructor)) void entry(){
    NSLog(@"\n               🎉!!！congratulations!!！🎉\n👍----------------insert dylib success----------------👍");
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        CYListenServer(6666);
    }];
}

#pragma mark - WeChatActionSheet

CHDeclareClass(WCActionSheet)
CHOptimizedMethod0(self, NSArray *, WCActionSheet, buttonTitleList){
    NSArray *titles = CHSuper0(WCActionSheet, buttonTitleList);
//    NSLog(@"WCActionSheet titles: %@, class: %@", titles, NSStringFromClass([[titles firstObject] class]));
    return titles;
}

CHOptimizedMethod1(self, void, WCActionSheet, showInView, UIView *, view){
    if ([WeChatSaveData defaultSaveData].isNeedAddMenu) {
        [self addButtonWithTitle:@""];
        [self addButtonWithTitle:kScreenshotTitle];
        [self addButtonWithTitle:kScreenshotTitleMask];
        
        // 方法二
//        WCActionSheetItem *shotItem = [[objc_getClass("WCActionSheetItem") alloc] initWithTitle:kScreenshotTitle];
//        WCActionSheetItem *shotItem2 = [[objc_getClass("WCActionSheetItem") alloc] initWithTitle:kScreenshotTitleMask];
//        [self.buttonTitleList addObject:shotItem];
//        [self.buttonTitleList addObject:shotItem2];
    }
    CHSuper1(WCActionSheet, showInView, view);
}

CHDeclareClass(WCActionSheetItem);
// 不点击菜单按钮时，点击取消或者其它空白的地方时 index 一直为最后加的菜单对应的 index，这里加个空白的
CHOptimizedMethod0(self, double, WCActionSheetItem, getItemHeight){
    double heigth = CHSuper0(WCActionSheetItem, getItemHeight);
    if(self.title.length == 0) {
        return 0;
    }
    return heigth;
}

#pragma mark - 收藏消息详情

CHDeclareClass(FavRecordDetailViewController)
CHOptimizedMethod2(self, void, FavRecordDetailViewController, actionSheet, WCActionSheet*, sheet, clickedButtonAtIndex, int, index){
    NSLog(@"Hook clickedButtonAtIndex");

    CHSuper2(FavRecordDetailViewController, actionSheet, sheet, clickedButtonAtIndex, index);
    
    [WeChatCapture saveCaptureImageWithSheet:sheet index:index viewController:self];
}

CHOptimizedMethod2(self, UITableViewCell *, FavRecordDetailViewController, tableView, MMTableView *, tableViewArg, cellForRowAtIndexPath, NSIndexPath, *indexPath){
    
    UITableViewCell *cell = CHSuper2(FavRecordDetailViewController, tableView, tableViewArg, cellForRowAtIndexPath, indexPath);
    [WeChatCapture updateCellDataWithCell:cell indexPath:indexPath];
    
    return cell;
}

CHOptimizedMethod1(self, void, FavRecordDetailViewController, viewWillAppear, BOOL, arg){
    CHSuper1(FavRecordDetailViewController, viewWillAppear, arg);
    [WeChatCapture viewWillAppearAction];
}

CHOptimizedMethod1(self, void, FavRecordDetailViewController, viewWillDisappear, BOOL, arg){
    CHSuper1(FavRecordDetailViewController, viewWillDisappear, arg);
    [WeChatCapture viewWillDisappearAction];
}

#pragma mark - 消息记录

CHDeclareClass(MsgRecordDetailViewController);
CHOptimizedMethod1(self, void, MsgRecordDetailViewController, viewWillAppear, BOOL, arg){
    CHSuper1(MsgRecordDetailViewController, viewWillAppear, arg);
    [WeChatCapture viewWillAppearAction];
}

CHOptimizedMethod1(self, void, MsgRecordDetailViewController, viewWillDisappear, BOOL, arg){
    CHSuper1(MsgRecordDetailViewController, viewWillDisappear, arg);
    [WeChatCapture viewWillDisappearAction];
}

CHOptimizedMethod2(self, void, MsgRecordDetailViewController, actionSheet, WCActionSheet*, sheet, clickedButtonAtIndex, int, index){
    NSLog(@"Hook clickedButtonAtIndex");

    CHSuper2(MsgRecordDetailViewController, actionSheet, sheet, clickedButtonAtIndex, index);

    [WeChatCapture saveCaptureImageWithSheet:sheet index:index viewController:self];
}

CHOptimizedMethod2(self, UITableViewCell *, MsgRecordDetailViewController, tableView, MMTableView *, tableViewArg, cellForRowAtIndexPath, NSIndexPath, *indexPath){

    UITableViewCell *cell = CHSuper2(MsgRecordDetailViewController, tableView, tableViewArg, cellForRowAtIndexPath, indexPath);
    [WeChatCapture updateCellDataWithCell:cell indexPath:indexPath];

    return cell;
}

#pragma mark - 构造

CHConstructor{
    CHLoadLateClass(WCActionSheet);
    CHClassHook0(WCActionSheet, buttonTitleList);
    CHClassHook1(WCActionSheet, showInView);
    
    CHLoadLateClass(WCActionSheetItem);
    CHClassHook0(WCActionSheetItem, getItemHeight);
    
    CHLoadLateClass(FavRecordDetailViewController);
    CHClassHook2(FavRecordDetailViewController, actionSheet, clickedButtonAtIndex);
    CHClassHook2(FavRecordDetailViewController, tableView, cellForRowAtIndexPath);
    CHClassHook1(FavRecordDetailViewController, viewWillAppear);
    CHClassHook1(FavRecordDetailViewController, viewWillDisappear);
    
    CHLoadLateClass(MsgRecordDetailViewController);
    CHClassHook2(MsgRecordDetailViewController, actionSheet, clickedButtonAtIndex);
    CHClassHook2(MsgRecordDetailViewController, tableView, cellForRowAtIndexPath);
    CHClassHook1(MsgRecordDetailViewController, viewWillAppear);
    CHClassHook1(MsgRecordDetailViewController, viewWillDisappear);
}

