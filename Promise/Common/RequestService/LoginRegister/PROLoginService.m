//
//  PROLoginService.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROLoginService.h"

@implementation PROLoginService

+ (void)logInWithUsername:(NSString *)username password:(NSString *)password complate:(PROLoginResultBlock)complate {
    [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            // 登录成功
            safe_block(complate,user,nil)
        } else {
            // 登录失败（可能是密码错误）
            safe_block(complate,nil,error)
        }
    }];
}

+ (void)logInWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password complate:(PROLoginResultBlock)complate {
    [AVUser logInWithMobilePhoneNumberInBackground:phoneNumber password:password block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            // 登录成功
            safe_block(complate,user,nil)
        } else {
            // 登录失败（可能是密码错误）
            safe_block(complate,nil,error)
        }
    }];
}

+ (void)logout {
    [AVUser logOut];
}

@end
