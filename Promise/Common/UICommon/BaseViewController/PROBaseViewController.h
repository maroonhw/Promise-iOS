//
//  PROBaseViewController.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PROBaseViewController : UIViewController

@property (nonatomic, assign) BOOL needBackButton;

@property (nonatomic, copy) NSString *pageTitle;

@end

NS_ASSUME_NONNULL_END
