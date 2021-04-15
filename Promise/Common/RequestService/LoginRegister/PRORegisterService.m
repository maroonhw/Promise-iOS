//
//  PRORegisterService.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PRORegisterService.h"

@implementation PRORegisterService

+ (void)registerSendVerificationCode:(NSString *)phoneNumber
                            complate:(PROSendVerificationCodeResultBlock)complate {
    AVShortMessageRequestOptions *options = [[AVShortMessageRequestOptions alloc] init];
    options.templateName = @"template_name";// 控制台配置好的模板名称
    options.signatureName = @"sign_name";     // 控制台配置好的短信签名
    [AVSMS requestShortMessageForPhoneNumber:phoneNumber options:nil callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            safe_block(complate,YES,nil);
        } else {
            safe_block(complate,NO,error);
        }
    }];
}

+ (void)registerWithverificationCode:(NSString *)verificationCode
                         phoneNumber:(NSString *)phoneNumber
                            complate:(PRORegisterResultBlock)complate {
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:phoneNumber smsCode:verificationCode block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            // 注册成功
            NSLog(@"注册成功。objectId：%@", user.objectId);
        } else {
            // 验证码不正确
        }
    }];
}

+ (void)registerWithUsername:(NSString *)username
                 phoneNumber:(NSString *)phoneNumber
                    password:(NSString *)password
                    complate:(PRORegisterUserInfoResultBlock)complate {
    AVUser *user = [AVUser user];
    user.username = username ? : phoneNumber;
    user.password = password;
    user.mobilePhoneNumber = phoneNumber;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 注册成功
            safe_block(complate,YES,nil);
        } else {
            // 注册失败（通常是因为用户名已被使用）
            safe_block(complate,NO,error);
            
        }
    }];
}


@end
