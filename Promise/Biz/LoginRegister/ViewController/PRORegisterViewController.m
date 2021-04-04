//
//  PRORegisterViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PRORegisterViewController.h"
#import "PRORegisterViewModel.h"

@interface PRORegisterViewController ()

@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *confirmPasswordTextField;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) PRORegisterViewModel *viewModel;

@end

@implementation PRORegisterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[PRORegisterViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
}

- (void)setupView {
    [self.view addSubview:self.phoneNumberTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.confirmPasswordTextField];
    [self.view addSubview:self.registerButton];

    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(120);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.phoneNumberTextField.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    [self.confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.confirmPasswordTextField.mas_bottom).offset(140);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}

- (void)registerAction {
    self.viewModel.phoneNumber = self.phoneNumberTextField.text;
    self.viewModel.password = self.passwordTextField.text;
    self.viewModel.confirmPassword = self.confirmPasswordTextField.text;
    if (![self.viewModel verifyMobileNumberFormat]) {
        NSLog(@"手机号格式不对！！！");
        return;
    }
    if (![self.viewModel verifyPassword]) {
        NSLog(@"两个密码不一样！！！");
        return;
    }
    [self.viewModel registerAccount];
}

#pragma Getter

- (UITextField *)phoneNumberTextField {
    if (!_phoneNumberTextField) {
        _phoneNumberTextField = [[UITextField alloc] init];
        _phoneNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _phoneNumberTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _passwordTextField;
}

- (UITextField *)confirmPasswordTextField {
    if (!_confirmPasswordTextField) {
        _confirmPasswordTextField = [[UITextField alloc] init];
        _confirmPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _confirmPasswordTextField;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] init];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.backgroundColor = [UIColor orangeColor];
        [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

@end
