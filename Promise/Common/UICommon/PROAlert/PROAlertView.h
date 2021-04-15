//
//  PROAlertView.h
//  AirPayCounter
//
//  Created by Hongwei Liu on 2019/6/13.
//  Copyright © 2019 Shopee. All rights reserved.
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

/*
 使用masonry布局时，横向展示alert需要重新设置子view布局，否者会出现布局混乱
 */
- (void)updateContainerMasonry;
@end


NS_ASSUME_NONNULL_END
