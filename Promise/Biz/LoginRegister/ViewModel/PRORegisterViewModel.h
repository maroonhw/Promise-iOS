//
//  PRORegisterViewModel.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^PRORegisterWithPhoneNumberBlock)(NSError * _Nullable error);

@interface PRORegisterViewModel : NSObject

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *confirmPassword;


- (void)registerAccount:(PRORegisterWithPhoneNumberBlock)complate;

- (BOOL)verifyPassword;

- (BOOL)verifyMobileNumberFormat;

@end

NS_ASSUME_NONNULL_END
