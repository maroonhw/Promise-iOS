//
//  PROAlertModel.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/4/22.
//  Copyright © 2021 Hongwei Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PROAlertViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface PROAlertActionModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) PROAlertActionStyle style;
@property (nonatomic, copy) void(^actionHandler)(id sender);

@end

@interface PROAlertModel : NSObject

@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) BOOL manualDismissAlert;
@property (nonatomic, assign) PROAlertLevel alertLevel;
@property (nonatomic, copy) UIImage *topImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *firstButtonTitle;
@property (nonatomic, copy) NSString *secondButtonTitle;
@property (nonatomic, assign) BOOL rotation;
@property (nonatomic, copy) void(^firstButtonHandler)(id sender);
@property (nonatomic, copy) void(^secondButtonHandler)(id sender);
@property (nonatomic, copy) void (^backFromBackground)(void);
@property (nonatomic, strong) NSArray<PROAlertAction *> *actionArray;
@property (nonatomic, copy) void(^showHandler)(void);

@end

NS_ASSUME_NONNULL_END
