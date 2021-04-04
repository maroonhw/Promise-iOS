//
//  PRORegisterService.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

typedef void (^PROSendVerificationCodeResultBlock)(BOOL succeeded,  NSError * _Nullable error);
typedef void (^PRORegisterResultBlock)(AVUser * _Nullable user, NSError *_Nullable error);
typedef void (^PRORegisterUserInfoResultBlock)(BOOL succeeded,  NSError * _Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface PRORegisterService : NSObject

+ (void)registerSendVerificationCode:(NSString *)phoneNumber
                            complate:(PROSendVerificationCodeResultBlock)complate;

+ (void)registerWithverificationCode:(NSString *)verificationCode
                         phoneNumber:(NSString *)phoneNumber
                            complate:(PRORegisterResultBlock)complate;

+ (void)registerWithUsername:(NSString *_Nullable)username
                 phoneNumber:(NSString *_Nonnull)phoneNumber
                    password:(NSString *_Nonnull)password
                    complate:(PRORegisterUserInfoResultBlock)complate;

@end

NS_ASSUME_NONNULL_END
