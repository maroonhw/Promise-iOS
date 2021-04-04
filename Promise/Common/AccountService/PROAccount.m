//
//  PROAccount.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROAccount.h"

@implementation PROAccount

+ (PROAccount *)sharedInstance {
    static PROAccount *account = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        account = [PROAccount new];
        
    });
    return account;
}

- (NSString *)userName {
    return [AVUser currentUser].username;
}

- (NSString *)phoneNumber {
    return [AVUser currentUser].mobilePhoneNumber;
}

- (NSString *)email {
    return [AVUser currentUser].email;
}

- (BOOL)login {
    return [AVUser currentUser] != nil;
}

@end
