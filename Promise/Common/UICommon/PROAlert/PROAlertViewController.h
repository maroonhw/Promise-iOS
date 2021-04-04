//
//  PROAlertViewController.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/22.
//  Copyright © 2021 Hongwei Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PROAlertActionStyle) {
    PROAlertActionStyleDefault = 0,
    PROAlertActionStyleCancel,
    PROAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, PROAlertLevel) {
    PROAlertLevelNormal = 0,
    PROAlertLevelMedium = 1000,
    PROAlertLevelTop    = 9999
};

@interface PROAlertAction : NSObject

@property (nonatomic, copy, readonly) PROAlertAction * (^title)(NSString * _Nullable);
@property (nonatomic, copy, readonly) PROAlertAction * (^style)(PROAlertActionStyle);
@property (nonatomic, copy, readonly) PROAlertAction * (^actionHandler)(void (^)(id _Nullable sender));

@end

@interface PROAlertViewController : UIViewController

@property (nonatomic, copy, readonly) void (^show)(void);
@property (nonatomic, copy, readonly) void (^showActionSheet)(void);


@property (nonatomic, copy, readonly) PROAlertViewController * (^topImage)(UIImage * _Nullable);

@property (nonatomic, copy, readonly) PROAlertViewController * (^alertTitle)(NSString * _Nullable);
@property (nonatomic, copy, readonly) PROAlertViewController * (^message)(NSString * _Nullable);
@property (nonatomic, copy, readonly) PROAlertViewController * (^alertLevel)(PROAlertLevel level);
@property (nonatomic, copy, readonly) PROAlertViewController * (^alertRotation)(BOOL rotation);

/**是否外部手动隐藏alert*/
@property (nonatomic, copy, readonly) PROAlertViewController * (^manualDismissAlert)(BOOL manual);
@property (nonatomic, copy, readonly) PROAlertViewController * (^firstButtonTitle)(NSString * _Nullable);
@property (nonatomic, copy, readonly) PROAlertViewController * (^secondButtonTitle)(NSString * _Nullable);
@property (nonatomic, copy, readonly) PROAlertViewController * (^firstButtonHandler)(void (^)(id _Nullable sender));
@property (nonatomic, copy, readonly) PROAlertViewController * (^secondButtonHandler)(void (^)(id _Nullable sender));
@property (nonatomic, copy, readonly) PROAlertViewController * (^backFromBackground)(void (^)(void));
@property (nonatomic, copy, readonly) PROAlertViewController * (^actionArray)(NSArray<PROAlertAction *> * _Nullable);

@property (nonatomic, copy, readonly) PROAlertViewController * (^showHandler)(void (^)(void));

- (void)dismiss;

+ (void)clearAlertPool;

@end

NS_ASSUME_NONNULL_END
