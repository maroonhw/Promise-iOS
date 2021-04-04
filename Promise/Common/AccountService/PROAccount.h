//
//  PROAccount.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PROAccount : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL login;

+ (PROAccount *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
