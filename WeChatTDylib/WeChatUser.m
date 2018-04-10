//
//  WeChatUser.m
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/4/3.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import "WeChatUser.h"

static NSInteger user_index = 0;

@implementation WeChatUser

+ (WeChatUser *)user
{
    WeChatUser *aUser = [[WeChatUser alloc] init];
    if (user_index >= [self userArray].count) {
        return aUser;
    }
    
    NSDictionary *userDict = [[self userArray] objectAtIndex:user_index];
    aUser.icon = userDict[@"icon"];
    aUser.nickname = userDict[@"nickname"];
    
    user_index += 1;
    
    return aUser;
}

+ (void)resetIndex
{
    user_index = 0;
}

+ (NSArray *)userArray
{
    static dispatch_once_t onceToken;
    static NSArray *users;
    dispatch_once(&onceToken, ^{
        users = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"]];
    });
    return users;
}

@end
