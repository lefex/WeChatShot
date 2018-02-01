//
//  WeChatHeader.m
//  WeChatTDylib
//
//  Created by Wang,Suyan on 2018/1/31.
//  Copyright © 2018年 Wang,Suyan. All rights reserved.
//

#import "WeChatHeader.h"
#import <AudioToolbox/AudioToolbox.h>

static SystemSoundID sysSoundID = 1108;


@implementation WeChatHeader

+ (UIImage *)captureScrollView:(UIScrollView *)view
{
    if (@available(iOS 9.0, *)) {
        AudioServicesPlaySystemSoundWithCompletion(sysSoundID, ^{
            AudioServicesDisposeSystemSoundID(sysSoundID);
        });
    }
    
    CGRect tempFrame = view.frame;
    CGPoint tempPoint = view.contentOffset;
    
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.contentSize.width, view.contentSize.height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.contentSize.width, view.contentSize.height), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext: context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

    view.contentOffset = tempPoint;
    view.frame = tempFrame;
    
    return image;
}

+ (UIImage *)addWatemarkTextWithImage:(UIImage *)image text:(NSString *)text
{
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] set];
    [image drawInRect:CGRectMake(0, 0, w, h)];
    UIFont * font = [UIFont systemFontOfSize:16];
    CGFloat textWidth = [self widthWithHeight:30 font:font title:text];
    [text drawInRect:CGRectMake(w - textWidth - 20, h - 30, w, 30) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (CGRect)rectWithSize:(CGSize)size font:(UIFont *)font title:(NSString *)title
{
    CGFloat lineSpace = 3;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSParagraphStyleAttributeName : paragraphStyle
                            };
    
    return [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}

+ (CGFloat)widthWithHeight:(CGFloat)height font:(UIFont *)font title:(NSString *)title
{
    return [self rectWithSize:CGSizeMake(MAXFLOAT, height) font:font title:title].size.width;
}

@end

