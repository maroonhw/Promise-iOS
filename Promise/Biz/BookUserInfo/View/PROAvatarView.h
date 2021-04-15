//
//  PROAvatarView.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PROAvatarViewSelectBlock)(void);


@interface PROAvatarView : UIView

@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, copy) PROAvatarViewSelectBlock selectPhotoComplate;

@end

NS_ASSUME_NONNULL_END
