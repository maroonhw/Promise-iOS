//
//  PROCusButton.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PROCusButtonStyle) {
    PROCusButtonStyleNormal,
    PROCusButtonStyleHollow
};

@interface PROCusButton : UIButton

@property(nonatomic, assign) PROCusButtonStyle style;

- (void)updateCusButtonStatus:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
