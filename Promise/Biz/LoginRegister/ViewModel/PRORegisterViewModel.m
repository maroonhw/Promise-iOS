//
//  PRORegisterViewModel.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PRORegisterViewModel.h"
#import "PRORegisterService.h"

@implementation PRORegisterViewModel


- (BOOL)verifyPassword {
    if (!NULLString(self.password) && !NULLString(self.confirmPassword) && [self.password isEqualToString:self.confirmPassword]) {
        return YES;
    }
    return NO;
}

- (BOOL)verifyMobileNumberFormat {
    /*
     手机号码
     移动: 134[0-8], 135, 136, 137, 138, 139, 150, 151, 158, 159, 182, 187, 188
     联通: 130, 131, 132, 152, 155, 156, 185, 186
     电信: 133, 1349, 153, 180, 189
     */
    NSString * MOBILE = @"@^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /*
     中国移动: China Mobile
     移动: 134[0-8], 135, 136, 137, 138, 139, 150, 151, 158, 159, 182, 187, 188
     */
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /*
     中国联通: China Unicom
     联通: 130, 131, 132, 152, 155, 156, 185, 186
     */
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /*
     中国电信: China Telecom
     电信: 133, 1349, 153, 180, 189
     */
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /*
     大陆地区固定电话及小灵通
     区号: 010, 020, 021, 022, 023, 024, 025, 027, 028, 029
     号码: 七位或八位
     */
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    if (([regextestmobile evaluateWithObject:self.phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:self.phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:self.phoneNumber] == YES)
        || ([regextestct evaluateWithObject:self.phoneNumber] == YES))
    {
        return YES;
    }else {
        return NO;
    }
    
}

#pragma Request
- (void)registerAccount {
    __weak typeof(self) weakSelf = self;
    [PRORegisterService registerWithUsername:self.phoneNumber phoneNumber:self.phoneNumber password:self.password complate:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [PROAccount sharedInstance].phoneNumber = weakSelf.phoneNumber;
        }
    }];
}

@end
