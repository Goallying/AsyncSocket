//
//  CToast.h
//  eshop
//
//  Created by huangboning on 14-12-5.
//  Copyright (c) 2014年 huangboning. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 2.0f

@interface CToast : NSObject
+ (void)showWithText:(NSString *) text_;
+ (void)showWithText:(NSString *) text_ duration:(CGFloat)duration_;

+ (void)showWithText:(NSString *) text_ topOffset:(CGFloat) topOffset_;
+ (void)showWithText:(NSString *) text_ topOffset:(CGFloat) topOffset duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_ bottomOffset:(CGFloat) bottomOffset_;
+ (void)showWithText:(NSString *) text_ bottomOffset:(CGFloat) bottomOffset_ duration:(CGFloat) duration_;

@end
