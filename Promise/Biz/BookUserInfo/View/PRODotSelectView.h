//
//  PRODotSelectView.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PRODotSelectViewOption) {
    PRODotSelectViewOptionFirst,
    PRODotSelectViewOptionSecond
};

@interface PRODotSelectView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) PRODotSelectViewOption option;

@property (nonatomic, copy) NSString *firstOptionTitle;

@property (nonatomic, copy) NSString *secondOptionTitle;

@end

NS_ASSUME_NONNULL_END
