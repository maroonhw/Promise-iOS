//
//  PROTitleTextField.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PROTitleTextFieldDidChangeBlock)(NSString *text);


@interface PROTitleTextField : UIView

@property (nonatomic,copy) NSString *title;

@property(nonatomic, copy) NSString *placeholder;

@property(nonatomic, copy) PROTitleTextFieldDidChangeBlock textFieldDidChangeHandler;

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
