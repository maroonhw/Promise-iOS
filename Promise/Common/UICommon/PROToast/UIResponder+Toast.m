//
//  UIResponder+APCToast.m
//  APCUIKit
//
//

#import "UIResponder+Toast.h"
#import <objc/runtime.h>
#import "PROToastView.h"

const void *toastViewKey = &toastViewKey;

@implementation UIResponder (Toast)

- (void)setToastView:(PROToastView *)toastView {
    objc_setAssociatedObject(self, toastViewKey, toastView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

- (PROToastView *)toastView {
    return objc_getAssociatedObject(self, toastViewKey);
}

- (void)removeToastView {
    objc_setAssociatedObject(self, toastViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public Methods
- (void)hideLoadingView {
    [self hiddenLoadingView:YES];
}

- (void)hiddenLoadingView:(BOOL)animation {
    if ([self toastView]) {
        [[self toastView] hiddenToastView:animation];
        [self removeToastView];
    }
}

- (void)showToastWithMessage:(NSString *)message {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self;
        [self showToastWithMessage:message inView:vc.view animation:YES];
        return;
    }
    [self showToastWithMessage:message inView:[PROUIUtil topViewController].view animation:YES];
}

- (void)showToastSuccessMessage:(NSString *)message {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self;
        [self showToastWithMessage:message inView:vc.view success:YES animation:YES];
        return;
    }
    [self showToastWithMessage:message inView:[PROUIUtil topViewController].view success:YES animation:YES];
}

- (void)showToastErrorMessage:(NSString *)message {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self;
        [self showToastWithMessage:message inView:vc.view success:NO animation:YES];
        return;
    }
    [self showToastWithMessage:message inView:[PROUIUtil topViewController].view success:NO animation:YES];
}

- (void)showRotationToastErrorMessage:(nullable NSString *)message {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self;
        [self showRotationToastWithMessage:message inView:vc.view success:NO animation:YES];
        return;
    }
    [self showRotationToastWithMessage:message inView:[PROUIUtil topViewController].view success:NO animation:YES];
}

- (void)showToastWithMessage:(NSString *)message inView:(UIView *)view {
    [self showToastWithMessage:message inView:view animation:YES];
}

- (void)showToastErrorMessage:(NSString *)message inView:(UIView *)view {
    [self showToastWithMessage:message inView:view success:NO animation:YES];
}

- (void)showToastSuccessMessage:(NSString *)message inView:(UIView *)view {
    [self showToastWithMessage:message inView:view success:YES animation:YES];
}

- (void)showToastMessageOnWindow:(NSString *)message {
    [self showToastWithMessage:message inView:[UIApplication sharedApplication].delegate.window animation:YES];
}

- (void)showToastSuccessMessageOnWindow:(NSString *)message {
    [self showToastWithMessage:message inView:[UIApplication sharedApplication].delegate.window success:YES animation:YES];
}

- (void)showToastErrorMessageOnWindow:(NSString *)message {
    [self showToastWithMessage:message inView:[UIApplication sharedApplication].delegate.window success:NO animation:YES];
}

- (void)showToastWithMessage:(NSString *)message inView:(UIView *)view animation:(BOOL)animation {
    if ([self toastView]) {
        return;
    }
    PROToastView *toastView = [PROToastView showToastWithMessage:message inView:view animation:animation];
    [self setToastView:toastView];
    mweakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(toastShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        mstrongify(self);
        [self removeToastView];
    });
}

- (void)showToastWithMessage:(NSString *)message inView:(UIView *)view success:(BOOL)success animation:(BOOL)animation {
    if ([self toastView]) {
        return;
    }
    PROToastView *toastView = [PROToastView showToastWithMessage:message inView:view success:success animation:animation];
    [self setToastView:toastView];
    mweakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(toastShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        mstrongify(self);
        [[self toastView] removeFromSuperview];
        [self removeToastView];
    });
}

- (void)showRotationToastWithMessage:(NSString *)message inView:(UIView *)view success:(BOOL)success animation:(BOOL)animation {
    if ([self toastView]) {
        return;
    }
    
    PROToastView *toastView =[PROToastView showRotationToastWithMessage:message inView:view success:success animation:animation];
    
    [self setToastView:toastView];
    mweakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(toastShowTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        mstrongify(self);
        [[self toastView] removeFromSuperview];
        [self removeToastView];
    });
}

- (void)showLoadingView {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self;
        [self showLoadingWithMessage:nil inView:vc.view animation:YES];
        return;
    }
    [self showLoadingWithMessage:nil inView:[PROUIUtil topViewController].view animation:YES];
}

- (void)showLoadingWithMessage:(NSString *)message {
    if ([self isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self;
        [self showLoadingWithMessage:message inView:vc.view animation:YES];
        return;
    }
    [self showLoadingWithMessage:message inView:[PROUIUtil topViewController].view animation:YES];
}

- (void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view animation:(BOOL)animation {
    if ([self toastView]) {
        return;
    }
    PROToastView *toastView = [PROToastView showLoadingWithMessage:message inView:view animation:animation];
    [self setToastView:toastView];
}

@end
