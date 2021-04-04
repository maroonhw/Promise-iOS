//
//  PROUIUtil.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define MScreenHeight [PROUIUtil screenHeightCurOrientation]      // 竖屏时的高度
#define MScreenWidth  [PROUIUtil screenWidthCurOrientation]       // 横屏时的宽度

@interface PROUIUtil : NSObject

+ (CGFloat)screenHeightCurOrientation;

/// 更改图片的颜色
/// @param image 更改图片
/// @param color  颜色
+ (UIImage *)imageChangeColor:(UIImage *)image color:(UIColor *)color;

/// 给view四周设置圆角
/// @param view  目标view
/// @param corners 查看UIRectCorner
/// @param radius radius
+ (void)addViewRoundCornersView:(UIView *)view   corners:(UIRectCorner)corners radius:(CGFloat)radius;

/// 当前app主window 显示的顶部VC
+ (UIViewController *)topViewController;

@end

NS_ASSUME_NONNULL_END
