//
//  PRORegisterPasswordViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PRORegisterPasswordViewController.h"
#import "PRONumberTextField.h"
#import "PROCusButton.h"
#import "PRORegisterViewModel.h"
#import "PROBookUserInfoViewController.h"

@interface PRORegisterPasswordViewController ()

@property (nonatomic, strong) PRONumberTextField *passwordTextField;

@property (nonatomic, strong) PRONumberTextField *passwordConfirmTextField;

@property (nonatomic, strong) PROCusButton *doneButton;

@property (nonatomic, strong) UILabel *pageTitle;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) PRORegisterViewModel *viewModel;


@end

@implementation PRORegisterPasswordViewController

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
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = MCOLOR(@"#44606b");
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.passwordConfirmTextField];
    [self.view addSubview:self.doneButton];
    [self.view addSubview:self.pageTitle];
    [self.view addSubview:self.backButton];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(18);
        make.top.mas_equalTo(MStatusBarHeight + 14);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(14);
    }];
    
    [self.pageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(MStatusBarHeight + 13);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.view).offset(MStatusBarHeight + 87);
        make.height.mas_equalTo(46);
    }];
    
    [self.passwordConfirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(12);
        make.height.mas_equalTo(46);
    }];
    
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.passwordConfirmTextField.mas_bottom).offset(35);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(105);
    }];
}

- (void)passwordTextFieldDidChange:(NSString *)text {
    self.viewModel.password = text;
    [self updateLoginButtonStatus];
}

- (void)passwordConfirmTextFieldDidChange:(NSString *)text {
    self.viewModel.confirmPassword = text;
    [self updateLoginButtonStatus];
}

- (void)updateLoginButtonStatus {

    BOOL enabled = NO;
    if (!NULLString(self.viewModel.password) && !NULLString(self.viewModel.confirmPassword)) {
        enabled = YES;
    }
    [self.doneButton updateCusButtonStatus:enabled];
}

- (void)backPage {
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}

- (void)registerAction {
    if (![self.viewModel.password isEqualToString:self.viewModel.confirmPassword]) {
        [PROToastView showToastWithMessage:@"两次输入密码不一致" inView:self.view animation:YES];
        return;
    }
    [self.viewModel registerAccount:^(NSError * _Nullable error) {
        if (error) {
            [PROToastView showToastWithMessage:@"注册失败" inView:self.view animation:YES];
            return;
        }
        [PROToastView showToastWithMessage:@"注册成功" inView:self.view animation:YES];
        PROBookUserInfoViewController *vc = [[PROBookUserInfoViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:vc animated:YES completion:^{
                    
        }];
    }];
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = phoneNumber;
    self.viewModel.phoneNumber = phoneNumber;
}

#pragma Getter
- (PRONumberTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[PRONumberTextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearsOnBeginEditing = YES;
        mweakify(self)
        _passwordTextField.textDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self passwordTextFieldDidChange:text];
        };
    }
    return _passwordTextField;
}

- (PRONumberTextField *)passwordConfirmTextField {
    if (!_passwordConfirmTextField) {
        _passwordConfirmTextField = [[PRONumberTextField alloc] init];
        _passwordConfirmTextField.placeholder = @"请确认密码";
        _passwordConfirmTextField.secureTextEntry = YES;
        _passwordConfirmTextField.clearsOnBeginEditing = YES;
        mweakify(self)
        _passwordConfirmTextField.textDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self passwordConfirmTextFieldDidChange:text];
        };
    }
    return _passwordConfirmTextField;
}

- (PROCusButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[PROCusButton alloc] init];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        _doneButton.enabled = NO;
        [_doneButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (UILabel *)pageTitle {
    if (!_pageTitle) {
        _pageTitle = [[UILabel alloc]init];
        [_pageTitle setFont:MMediumFont(18)];
        [_pageTitle setTextColor:MCOLOR_ALPHA(@"#ffffff",0.9)];
        _pageTitle.text = @"手机号注册";
        _pageTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _pageTitle;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

@end
