//
//  PROLoginViewModel.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROLoginViewModel.h"
#import "PROLoginService.h"

@implementation PROLoginViewModel

- (void)logInWithPhoneNumber:(PROlogInWithPhoneNumberBlock)complate {
    [PROLoginService logInWithPhoneNumber:self.phoneNumber password:self.password complate:^(AVUser * _Nullable user, NSError * _Nullable error) {
        if (user != nil) {
            /// 登录成功
            safe_block(complate,nil);
        } else {
            /// 登录失败
            safe_block(complate,error);
        }
    }];
}

@end
