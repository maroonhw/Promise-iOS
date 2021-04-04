//
//  PROToastView.m
//  AirPayCounter
//
//  Copyright © 2021 Hongwei Liu. All rights reserved.
//

#import "PROToastView.h"
#import "MBProgressHUD.h"


const NSUInteger toastShowTime = 2.5;
const CGFloat margin = 24.0;

@interface PROToastView ()

@property (nonatomic, strong, nullable) MBProgressHUD *hudView;

@end

@implementation PROToastView

#pragma mark - Public Methods
- (void)hiddenToastView:(BOOL)animation {
    [self.hudView hideAnimated:animation];
}

+ (PROToastView *)showLoadingWithMessage:(NSString *)message inView:(UIView *)view animation:(BOOL)animation {
    PROToastView *toastView = [PROToastView new];
    toastView.hudView = [self showHudView:message inView:view hudMode:MBProgressHUDModeIndeterminate animation:animation image:nil];
    return toastView;
}

+ (PROToastView *)showToastWithMessage:(NSString *)message inView:(UIView *)view animation:(BOOL)animation {
    PROToastView *toastView = [PROToastView new];
    toastView.hudView = [self showHudView:message inView:view hudMode:MBProgressHUDModeText animation:animation image:nil];
    toastView.hudView.square = NO;
    [toastView.hudView hideAnimated:YES afterDelay:toastShowTime];
    return toastView;
}

+ (PROToastView *)showToastWithMessage:(NSString *)message inView:(UIView *)view success:(BOOL)success animation:(BOOL)animation {
    PROToastView *toastView = [PROToastView new];
    UIImage *image = (success ? [UIImage imageNamed:@"toast_success"] :  [UIImage imageNamed:@"toast_warning"]);
    toastView.hudView = [self showHudView:message inView:view hudMode:MBProgressHUDModeCustomView animation:animation image:image];
    toastView.hudView.square = NO;
    [toastView.hudView hideAnimated:YES afterDelay:toastShowTime];
    return toastView;
}

+(PROToastView *)showRotationToastWithMessage:(NSString *)message inView:(UIView *)view success:(BOOL)success animation:(BOOL)animation {
    PROToastView *toastView = [PROToastView new];
    UIImage *image = (success ? [UIImage imageNamed:@"toast_success"] :  [UIImage imageNamed:@"toast_warning"]);
    toastView.hudView = [self showHudView:message inView:view hudMode:MBProgressHUDModeCustomView animation:animation image:image];
    toastView.hudView.square = NO;
    [toastView.hudView hideAnimated:YES afterDelay:toastShowTime];
    toastView.hudView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    return toastView;
}

+ (PROToastView *)showToastWithMessage:(NSString *)message inView:(UIView *)view iconPath:(NSString *)iconPath animation:(BOOL)animation {
    PROToastView *toastView = [PROToastView new];
    UIImage *img = [UIImage imageWithContentsOfFile:[NSURL URLWithString:iconPath].path];
    toastView.hudView = [self showHudView:message inView:view hudMode:MBProgressHUDModeCustomView animation:animation image:img];
    toastView.hudView.square = NO;
    [toastView.hudView hideAnimated:YES afterDelay:toastShowTime];
    return toastView;
}

#pragma mark - Private Methods
+ (MBProgressHUD *)showHudView:(NSString *)message inView:(UIView *)view hudMode:(MBProgressHUDMode)hudMode animation:(BOOL)animation image:(UIImage *)image {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.margin          = margin;
    hud.mode            = hudMode;
    hud.animationType   = MBProgressHUDAnimationZoom;
    if (hud.mode == MBProgressHUDModeCustomView && image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        hud.customView = imageView;
    }
    {
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.square = YES;
        hud.bezelView.color = MCOLOR_ALPHA(@"#000000", 0.6);
        hud.layer.cornerRadius = 4.0f;
    }
    {
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor clearColor];
    }
    {
        hud.contentColor = [UIColor whiteColor];
        hud.label.numberOfLines = 0;
        hud.label.text = message;
        hud.label.textColor = [UIColor whiteColor];
        hud.label.font = MRegularFont(14);
    }
    [view addSubview:hud];
    [hud showAnimated:animation];
    return hud;
}


@end
