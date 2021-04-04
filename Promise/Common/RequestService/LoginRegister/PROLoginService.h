//
//  PROLoginService.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PROLoginResultBlock)(AVUser * _Nullable user, NSError *_Nullable error);

@interface PROLoginService : NSObject

+ (void)logInWithUsername:(NSString *)username password:(NSString *)password complate:(PROLoginResultBlock)complate;

+ (void)logInWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password complate:(PROLoginResultBlock)complate;

+ (void)logout;

@end

NS_ASSUME_NONNULL_END
