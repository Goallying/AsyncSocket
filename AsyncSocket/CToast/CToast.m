//
//  CToast.m
//  eshop
//
//  Created by huangboning on 14-12-5.
//  Copyright (c) 2014年 huangboning. All rights reserved.
//

#import "CToast.h"

#define kScreenW   [UIScreen mainScreen].bounds.size.width
#define kScreenH   [UIScreen mainScreen].bounds.size.height

@implementation CToast{
    
    UIButton * _contentView;
    CGFloat    _duration;
    
    UIWindow * _instanceWindow ;
    UIWindow * _realWindow ;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
}


- (id)initWithText:(NSString *)text_ duration:(CGFloat)duration{
    if (self = [super init]) {
        
        _duration = duration;
        _realWindow = [UIApplication sharedApplication].keyWindow ;
        _instanceWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        
        UIFont *font = [UIFont boldSystemFontOfSize:17];
        CGRect textSize = [text_ boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.size.width + 12, textSize.size.height + 12)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text_;
        textLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.layer.borderWidth = 1.0f;
        _contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        _contentView.backgroundColor = [UIColor colorWithRed:0.2f
                                                      green:0.2f
                                                       blue:0.2f
                                                      alpha:0.75f];
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchUpInside];
        _contentView.alpha = 1;
        _contentView.center = _instanceWindow.center;
        [_instanceWindow addSubview:_contentView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self dismiss];
}
-(void)toastTaped:(UIButton *)sender_{
    [self dismiss];
}

- (void)show{

    [_realWindow resignKeyWindow];
    [_instanceWindow makeKeyAndVisible];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _contentView.alpha = 1;
                     }completion:^(BOOL finished) {
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismiss];
                         });
                     }];
}
- (void)dismiss {
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _contentView.alpha = 0;
                     }completion:^(BOOL finished) {
                         
                         [_contentView removeFromSuperview];
                         
                         [_instanceWindow resignKeyWindow];
                         [_realWindow makeKeyAndVisible];
                         
                     }];
 
}

//- (void)showFromTopOffset:(CGFloat) top_{
//
//    _contentView.centerY = top_ + _contentView.frame.size.height/2 ;
//    [self show];
//}
//
//- (void)showFromBottomOffset:(CGFloat) bottom_{
//
//    _contentView.centerY = kScreenH - (bottom_ + _contentView.frame.size.height/2) ;
//    [self show];
//}


+ (void)showWithText:(NSString *)text_{
    [CToast showWithText:text_ duration:DEFAULT_DISPLAY_DURATION];
}

+ (void)showWithText:(NSString *)text_
            duration:(CGFloat)duration_{
    CToast *toast = [[CToast alloc] initWithText:text_ duration:duration_];
    [toast show];
}

+ (void)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_{
    [CToast showWithText:text_  topOffset:topOffset_ duration:DEFAULT_DISPLAY_DURATION];
}

//+ (void)showWithText:(NSString *)text_
//           topOffset:(CGFloat)topOffset_
//            duration:(CGFloat)duration_{
//    CToast *toast = [[CToast alloc] initWithText:text_ duration:duration_];
//    [toast showFromTopOffset:topOffset_];
//}

+ (void)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_{
    [CToast showWithText:text_  bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
}

//+ (void)showWithText:(NSString *)text_
//        bottomOffset:(CGFloat)bottomOffset_
//            duration:(CGFloat)duration_{
//    CToast *toast = [[CToast alloc] initWithText:text_ duration:duration_];
//    [toast showFromBottomOffset:bottomOffset_];
//    
//}
@end
