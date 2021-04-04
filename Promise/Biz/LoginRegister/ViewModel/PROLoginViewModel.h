//
//  PROLoginViewModel.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PROlogInWithPhoneNumberBlock)(NSError * _Nullable error);

@interface PROLoginViewModel : NSObject

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *userName;

- (void)logInWithPhoneNumber:(PROlogInWithPhoneNumberBlock)complate;

@end

NS_ASSUME_NONNULL_END
