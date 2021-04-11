//
//  PRONumberTextField.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PRONumberTextFieldDidChangeBlock)(NSString *text);

typedef NS_ENUM(NSInteger, PRONumberTextFieldStyle) {
    PRONumberTextFieldStyleNumber,
    PRONumberTextFieldStylePassword
};

@class PRONumberTextField;

@protocol PRONumberTextFieldDelegate <NSObject>

- (void)numberTextField:(PRONumberTextField *)numberTextField text:(NSString *)text;

@end

@interface PRONumberTextField : UIView

@property(nonatomic, assign) BOOL secureTextEntry;

@property(nonatomic, assign) BOOL clearsOnBeginEditing;

@property(nonatomic, weak, nullable) id<PRONumberTextFieldDelegate> delegate;

@property(nonatomic, copy) NSString *placeholder;

@property(nonatomic, copy) PRONumberTextFieldDidChangeBlock textDidChangeHandler;

@end

NS_ASSUME_NONNULL_END
