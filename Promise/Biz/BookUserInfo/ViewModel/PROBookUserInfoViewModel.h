//
//  PROBookUserInfoViewModel.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PROBookUserInfoViewModel : NSObject

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *email;

@property(nonatomic, assign) NSInteger gender;

@property(nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
