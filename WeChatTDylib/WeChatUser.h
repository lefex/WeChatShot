//
//  WeChatUser.h
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/4/3.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatUser : NSObject

+ (WeChatUser *)user;
+ (void)resetIndex;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *nickname;

@end
