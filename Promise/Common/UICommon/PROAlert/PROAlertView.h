//
//  PROAlertView.h
//  AirPayCounter
//
//  Created by HuiCao on 2019/6/13.
//  Copyright © 2021 Hongwei Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PROAlertModel;

@interface PROAlertView : UIView


@property (nonatomic, copy) void (^firstButtonActionBlock)(UIButton *button);
@property (nonatomic, copy) void (^secondButtonActionBlock)(UIButton *button);

- (instancetype)initWithModel:(PROAlertModel *)model;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (void)setupContainerMasonry;

- (void)updateContainerMasonry;
@end


NS_ASSUME_NONNULL_END
