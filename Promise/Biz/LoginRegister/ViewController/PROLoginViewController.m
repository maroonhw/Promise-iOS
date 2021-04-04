//
//  PROLoginViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROLoginViewController.h"
#import "PROLoginViewModel.h"

@interface PROLoginViewController ()

@property (nonatomic, strong) PROLoginViewModel *viewModel;

@end

@implementation PROLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[PROLoginViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel.password = @"Lhw123456";
    self.viewModel.phoneNumber = @"15330342452";
    self.viewModel.userName = @"15330342452";
    [self.viewModel logInWithPhoneNumber:^(NSError * _Nullable error) {
        if (error) {
            [PROToastView showToastWithMessage:@"登录失败" inView:self.view animation:YES];
        } else {
            [PROToastView showToastWithMessage:@"登录成功" inView:self.view animation:YES];
        }
    }];
}



@end
