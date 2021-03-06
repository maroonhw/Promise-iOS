//
//  PRORegisterNumberViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PRORegisterNumberViewController.h"
#import "PRORegisterViewModel.h"
#import "PRONumberTextField.h"
#import "PROCusButton.h"
#import "PRORegisterPasswordViewController.h"


@interface PRORegisterNumberViewController ()

@property (nonatomic, strong) PRONumberTextField *numberTextField;

@property (nonatomic, strong) PROCusButton *nextButton;

@property (nonatomic, strong) UILabel *userAgreementLabel;

@property (nonatomic, strong) PRORegisterViewModel *viewModel;

@end

@implementation PRORegisterNumberViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[PRORegisterViewModel alloc] init];
        self.pageTitle = @"手机号注册";
        self.needBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void)setupView {
    self.view.backgroundColor = MCOLOR(@"#44606b");
    [self.view addSubview:self.numberTextField];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.userAgreementLabel];

    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.view).offset(-28);
        make.top.mas_equalTo(MTopBarHeight + 87);
        make.height.mas_equalTo(46);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-28);
        make.top.equalTo(self.numberTextField.mas_bottom).offset(35);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(110);
    }];
    [self.userAgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nextButton);
        make.left.equalTo(self.view).offset(28);
        make.right.equalTo(self.nextButton.mas_left).offset(-28);
    }];
    
}

- (void)backPage {
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}

- (void)loginAction {
    PRORegisterPasswordViewController *vc = [[PRORegisterPasswordViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.phoneNumber = self.viewModel.phoneNumber;
    [self presentViewController:vc animated:YES completion:^{
            
    }];
}


- (void)numberDidChange:(NSString *)text {
    self.viewModel.phoneNumber = text;
    [self updateLoginButtonStatus];
}

- (void)updateLoginButtonStatus {
    BOOL enabled = NO;
    if (!NULLString(self.viewModel.phoneNumber)) {
        enabled = YES;
    }
    [self.nextButton updateCusButtonStatus:enabled];
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

- (PROCusButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [[PROCusButton alloc] init];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextButton.enabled = NO;
        [_nextButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}


- (UILabel *)userAgreementLabel {
    if (!_userAgreementLabel) {
        _userAgreementLabel = [[UILabel alloc] init];
    }
    return _userAgreementLabel;
}


@end
