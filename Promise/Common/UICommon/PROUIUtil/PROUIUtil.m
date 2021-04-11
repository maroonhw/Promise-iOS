//
//  PROUIUtil.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROUIUtil.h"

@implementation PROUIUtil

+ (CGFloat)screenHeightCurOrientation {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat mainWindowHeight = [PROUIUtil mainWindowHeight];
    if (screenHeight != mainWindowHeight && UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && mainWindowHeight > 0)
    {
        return mainWindowHeight;
    }
    return screenHeight;
}

+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)normalStatusBarHeight {
    CGFloat statusBarHeight = [PROUIUtil statusBarHeight];
    if (statusBarHeight == 40) {
        return 20;
    }
    if (statusBarHeight == 0) {
        return 20;
    }
    return statusBarHeight;
}

+ (CGFloat)screenWidthCurOrientation {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat mainWindowWidth = [PROUIUtil mainWindowWidth];
    if (screenWidth != mainWindowWidth && UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) && mainWindowWidth > 0)
    {
        return mainWindowWidth;
    }
    return screenWidth;
}

+ (UIImage *)imageChangeColor:(UIImage *)image color:(UIColor *)color {
    //获取画布
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    //画笔沾取颜色
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (void)addViewRoundCornersView:(UIView *)view   corners:(UIRectCorner)corners radius:(CGFloat)radius {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = view.bounds;
    shapeLayer.path = rounded.CGPath;
    view.layer.mask = shapeLayer;
}

+ (UIViewController *)topViewController {
   return [self topViewControllerOfWindow:[[[UIApplication sharedApplication] delegate] window]];
}

+ (UIViewController *)topViewControllerOfWindow:(UIWindow*)window {
    UIViewController *vc = window.rootViewController;
    while (vc) {
        UIViewController *nextVc = nil;
        if ([vc isKindOfClass:[UITabBarController class]]) {
            nextVc = ((UITabBarController*)vc).selectedViewController;
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            nextVc = ((UINavigationController*)vc).visibleViewController;
        } else if ([vc isKindOfClass:[UISplitViewController class]]) {
            nextVc = [((UISplitViewController*)vc).viewControllers lastObject];
        } else {
            nextVc = vc.presentedViewController;
        }
        if (nextVc == nil) {
            return vc;
        }
        vc = nextVc;
    }
    return nil;
}

+ (CGFloat)safeBottomHeight {
    CGFloat bottomInset = 0;
    if (MIsiPhoneXSeries) {
        if (MScreenHeight == 812 || MScreenHeight == 896) {
            bottomInset = 34;
        } else if (MScreenWidth == 812 || MScreenWidth == 896) {
            bottomInset = 21;
        }
    }
    return bottomInset;
}



+ (CGFloat)tabBarHeight {
    if (MIsiPhoneXSeries) {
        return 83.0;
    }
    return 49.0;
}

+ (CGFloat)navigationBarHeight {
    return 44.0;
}

+ (BOOL)isiPhoneXSeries {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    // 获取屏幕的宽度和高度，取较大一方判断是否为 812.0 或 896.0
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat maxLength = screenWidth > screenHeight ? screenWidth : screenHeight;
    if (maxLength == 812.0f || maxLength == 896.0f) {
        iPhoneXSeries = YES;
    }
    
    return iPhoneXSeries;
}

+ (UIWindow *)appMainWindow {
    UIWindow *appWindow = nil;
    if ([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(window)]) {
        appWindow = [[[UIApplication sharedApplication] delegate] window];
    }else {
        appWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return appWindow;
}

+ (id<UIApplicationDelegate>)appDelegate {
    return [[UIApplication sharedApplication] delegate];
}

#pragma mark - private
+ (CGFloat)mainWindowHeight {
    return [[UIApplication sharedApplication] delegate].window.bounds.size.height;
}

+ (CGFloat)mainWindowWidth {
    return [[UIApplication sharedApplication] delegate].window.bounds.size.width;
}

@end
