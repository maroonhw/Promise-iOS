//
//  PROLoginViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROLoginViewController.h"
#import "PROLoginViewModel.h"
#import "PRONumberTextField.h"
#import "PROCusButton.h"
#import "PRORegisterNumberViewController.h"

#import "PRORegisterService.h"

@interface PROLoginViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *titleTextView;

@property (nonatomic, strong) PRONumberTextField *numberTextField;

@property (nonatomic, strong) PRONumberTextField *passwordTextField;

@property (nonatomic, strong) PROCusButton *loginButton;

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
    
    [self setupView];
}

- (void)setupView {
    [self initTextView];
    self.view.backgroundColor = MCOLOR(@"#44606b");
    [self.view addSubview:self.numberTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.titleTextView];
    [self.view addSubview:self.loginButton];
    
    [self.titleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.view).offset(-28);
        make.top.mas_equalTo(MTopBarHeight + 44);
        make.height.mas_equalTo(106);
    }];
    
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.titleTextView.mas_bottom).offset(87);
        make.height.mas_equalTo(46);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(12);
        make.height.mas_equalTo(46);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(35);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
    }];
}

- (void)initTextView {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"你好，\n欢迎来到Promise,  立即 注册" attributes:@{NSForegroundColorAttributeName:MCOLOR_ALPHA(@"#ffffff",0.8),NSFontAttributeName:MRegularFont(18)}];
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:MCOLOR(@"#ffffff"),
                                      NSFontAttributeName:MRegularFont(36)}
                              range:[[attributedString string] rangeOfString:@"你好，"]];
    
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"https://"
                             range:[[attributedString string] rangeOfString:@" 注册"]];
    
    [attributedString addAttributes:@{NSForegroundColorAttributeName:MCOLOR(@"#EE4D2D"),
                                      NSFontAttributeName:MBoldFont(18)}
                              range:[[attributedString string] rangeOfString:@" 注册"]];

    self.titleTextView.attributedText = attributedString;
    self.titleTextView.linkTextAttributes = @{NSUnderlineColorAttributeName:[UIColor redColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid),
                                         NSFontAttributeName:MRegularFont(18)};

    self.titleTextView.delegate = self;
    self.titleTextView.editable = NO;
    self.titleTextView.backgroundColor = [UIColor clearColor];
    self.titleTextView.scrollEnabled = NO;
}

- (void)loginAction {
    [self.viewModel logInWithPhoneNumber:^(NSError * _Nullable error) {
        if (error) {
            [PROToastView showToastWithMessage:@"登录成功" inView:self.view animation:YES];
            return;
        }
        [PROToastView showToastWithMessage:@"登录成功" inView:self.view animation:YES];

    }];
}

- (void)numberDidChange:(NSString *)text {
    self.viewModel.phoneNumber = text;
    [self updateLoginButtonStatus];
}

- (void)passwordDidChange:(NSString *)text {
    self.viewModel.password = text;
    [self updateLoginButtonStatus];
}

- (void)updateLoginButtonStatus {
    BOOL enabled = NO;
    if (!NULLString(self.viewModel.phoneNumber) && !NULLString(self.viewModel.password)) {
        enabled = YES;
    }
    [self.loginButton updateCusButtonStatus:enabled];
}

#pragma UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRang interaction:(UITextItemInteraction)interaction {
    PRORegisterNumberViewController *vc = [[PRORegisterNumberViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:YES completion:^{
            
    }];
    return NO;
}


#pragma Getter
- (PRONumberTextField *)numberTextField {
    if (!_numberTextField) {
        _numberTextField = [[PRONumberTextField alloc] init];
        _numberTextField.placeholder = @"请输入手机号";
        mweakify(self)
        _numberTextField.textDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self numberDidChange:text];
        };
    }
    return _numberTextField;
}

- (PRONumberTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[PRONumberTextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearsOnBeginEditing = YES;
        mweakify(self)
        _passwordTextField.textDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self passwordDidChange:text];
        };
    }
    return _passwordTextField;
}

- (UITextView *)titleTextView {
    if (!_titleTextView) {
        _titleTextView = [[UITextView alloc] init];
        _titleTextView.delegate = self;
    }
    return _titleTextView;
}

- (PROCusButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[PROCusButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
