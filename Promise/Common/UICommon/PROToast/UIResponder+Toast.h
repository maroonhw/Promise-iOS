//
//  UIResponder+APCToast.h
//  APCUIKit
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Toast)

/**
 移除当前显示的loadingView(默认显示动画)
 */
- (void)hideLoadingView;

/**
 移除当前显示的loadingView

 @param animation 是否需要动画
 */
- (void)hiddenLoadingView:(BOOL)animation;

/**
 显示loadingview 不消失，需要调用hideLoadingView才能消失(默认显示动画)
 */
- (void)showLoadingView;

/**
 显示loadingview 不消失，需要调用hideLoadingView才能消失
 
 @param message 显示文案
 */
- (void)showLoadingWithMessage:(nullable NSString *)message;

/**
 显示loadingview 不消失，需要调用hideLoadingView才能消失

 @param message 显示文案
 @param view 容器view
 @param animation 是否需要动画
 */
- (void)showLoadingWithMessage:(nullable NSString *)message
                                  inView:(UIView *)view
                               animation:(BOOL)animation;

/**
 显示toastview 2.5秒后会自动消失
 
 @param message 显示文案
 */
- (void)showToastWithMessage:(nullable NSString *)message;
- (void)showToastSuccessMessage:(nullable NSString *)message;
- (void)showToastErrorMessage:(nullable NSString *)message;
- (void)showToastErrorMessage:(nullable NSString *)message inView:(UIView *)view;
- (void)showToastSuccessMessage:(nullable NSString *)message inView:(UIView *)view;
- (void)showToastWithMessage:(nullable NSString *)message inView:(UIView *)view;
- (void)showRotationToastErrorMessage:(nullable NSString *)message;

/**
 在window上显示toastview 2.5秒后会自动消失

 @param message 显示文案
 */
- (void)showToastMessageOnWindow:(nullable NSString *)message;
- (void)showToastSuccessMessageOnWindow:(nullable NSString *)message;
- (void)showToastErrorMessageOnWindow:(nullable NSString *)message;

/**
 显示toastview 2.5秒后会自动消失

 @param message 显示文案
 @param view 容器view
 @param animation 是否需要动画
 */
- (void)showToastWithMessage:(nullable NSString *)message
                                inView:(UIView *)view
                             animation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
