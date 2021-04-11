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
#define MAppMainWindow [PROUIUtil appMainWindow]
#define MIsiPhoneXSeries [PROUIUtil isiPhoneXSeries]

#define MStatusBarHeight     [PROUIUtil statusBarHeight]          // 状态栏高度
#define MNavigationBarHeight [PROUIUtil navigationBarHeight]      // 竖屏时的导航栏高度
#define MTopBarHeight        ([PROUIUtil statusBarHeight] + [PROUIUtil navigationBarHeight])  //竖屏时状态栏高度+导航栏高度
#define MTabBarHeight        [PROUIUtil tabBarHeight]             // tabBar高度

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

+ (CGFloat)screenWidthCurOrientation;

/**
 状态栏高度
 
 @return 对应数值
 */
+ (CGFloat)statusBarHeight;

/**
 正常的状态栏高度（排除呼叫状态栏）
 
 @return 对应数值
 */
+ (CGFloat)normalStatusBarHeight;

/**
 navigationBar的高度，目前为写死44
 
 @return 对应数值
 */
+ (CGFloat)navigationBarHeight;

/**
 距离底部的间距，竖屏34，横屏21
 @return 对应数值
 */
+ (CGFloat)safeBottomHeight;

/**
 tabbar的高度，目前是取的tabBar默认值默认49，X是83
 @return 对应数值
 */
+ (CGFloat)tabBarHeight;

/**
 获取App的主window
 */
+ (UIWindow * _Nullable)appMainWindow;

/**
 获取App的delegate
 */
+ (id<UIApplicationDelegate> _Nullable)appDelegate;


/**
判断当前设备是否X系列

@return 返回结果
*/
+ (BOOL)isiPhoneXSeries;


@end

NS_ASSUME_NONNULL_END
