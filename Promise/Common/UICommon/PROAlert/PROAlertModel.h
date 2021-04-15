//
//  PROAlertModel.h
//  AirPayCounter
//
//  Created by Hongwei Liu on 2019/4/22.
//  Copyright © 2019 Shopee. All rights reserved.
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
@property (nonatomic, copy) NSURL *topImageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleTextColor;
@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) PROAlertFontWeight titleFontWeight;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *messageTextColor;
@property (nonatomic, assign) CGFloat messageFontSize;
@property (nonatomic, assign) PROAlertFontWeight messageFontWeight;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;
@property (nonatomic, copy) NSString *firstButtonTitle;
@property (nonatomic, copy) NSString *secondButtonTitle;
@property (nonatomic, copy) NSNumber *imageRatio;
@property (nonatomic, copy) void(^firstButtonHandler)(id sender);
@property (nonatomic, copy) void(^secondButtonHandler)(id sender);
@property (nonatomic, copy) void (^backFromBackground)(void);
@property (nonatomic, strong) NSArray<PROAlertAction *> *actionArray;
@property (nonatomic, copy) void(^showHandler)(void);

/// 如果topImage或者topImageURL非空，返回YES；否则NO
- (BOOL)hasTopImage;

@end

NS_ASSUME_NONNULL_END
