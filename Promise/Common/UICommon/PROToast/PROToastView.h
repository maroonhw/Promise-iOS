//
//  PROToastView.h
//  AirPayCounter
//
//  Copyright © 2021 Hongwei Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

OBJC_EXTERN const NSUInteger toastShowTime;

NS_ASSUME_NONNULL_BEGIN

@interface PROToastView : UIView

/**
 移除toastView

 @param animation 是否需要动画
 */
- (void)hiddenToastView:(BOOL)animation;


/**
 显示loadingview 不消失，需要调用hiddenToastView才能消失

 @param message 显示文案
 @param view 容器view
 @param animation 是否需要动画
 @return toastview
 */
+ (PROToastView *)showLoadingWithMessage:(nullable NSString *)message
                                  inView:(nonnull UIView *)view
                               animation:(BOOL)animation;


/**
 显示toastview 几秒后会自动消失

 @param message 显示文案
 @param view 容器view
 @param animation 是否需要动画
 @return toastview
 */
+ (PROToastView *)showToastWithMessage:(nullable NSString *)message
                                inView:(nonnull UIView *)view
                             animation:(BOOL)animation;

/**
 显示toastview 几秒后会自动消失

 @param message 显示文案
 @param view 容器view
 @param success 显示成功或失败的icon
 @param animation 是否需要动画
 @return toastview
 */
+ (PROToastView *)showToastWithMessage:(nullable NSString *)message
                                inView:(nonnull UIView *)view
                               success:(BOOL)success
                             animation:(BOOL)animation;
/**
显示toastview 几秒后会自动消失 ，旋转90度

@param message 显示文案
@param view 容器view
@param success 显示成功或失败的icon
@param animation 是否需要动画
@return toastview
*/
+(PROToastView *)showRotationToastWithMessage:(NSString *)message
                                       inView:(UIView *)view
                                      success:(BOOL)success
                                    animation:(BOOL)animation;
/**
显示toastview 几秒后会自动消失

@param message 显示文案
@param view 容器view
@param iconPath 图片本地路径
@param animation 是否需要动画
@return toastview
*/
+ (PROToastView *)showToastWithMessage:(NSString *)message
                                inView:(UIView *)view
                              iconPath:(NSString *)iconPath
                             animation:(BOOL)animation;
@end

NS_ASSUME_NONNULL_END
