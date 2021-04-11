//
//  PROBookUserInfoViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PROBookUserInfoViewController.h"
#import "PROTitleTextField.h"
#import "PRODotSelectView.h"
#import "PROBookUserInfoViewModel.h"
#import "PROCusButton.h"

@interface PROBookUserInfoViewController ()

@property(nonatomic, strong) PROTitleTextField *nameTextField;

@property(nonatomic, strong) PROTitleTextField *emailTextField;

@property(nonatomic, strong) PRODotSelectView *selectView;

@property(nonatomic, strong) PROCusButton *jumpButton;

@property(nonatomic, strong) PROCusButton *doneButton;

@property(nonatomic, strong) PROBookUserInfoViewModel *viewModel;

@end

@implementation PROBookUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = MCOLOR(@"#44606b");
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.jumpButton];
    [self.view addSubview:self.doneButton];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MTopBarHeight + 32);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MScreenWidth / 2.5);
    }];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom).offset(48);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(MScreenWidth / 2.5);
    }];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectView.mas_bottom).offset(48);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MScreenWidth / 2.5);
    }];
    
    [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).offset(110);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(105);
    }];
    
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).offset(110);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(105);
    }];
}

- (void)nameTextFieldDidChange:(NSString *)text {
    self.viewModel.name = text;
}

- (void)emailTextFieldDidChange:(NSString *)text {
    self.viewModel.email = text;
    [self updateButtonStatus];
}

- (void)jumpAction {
    
}

- (void)doneAction {
    
}

- (void)updateButtonStatus {
    BOOL enabled = NO;
    if (!NULLString(self.viewModel.email) && !NULLString(self.viewModel.email)) {
        enabled = YES;
    }
    [self.doneButton updateCusButtonStatus:enabled];
}

- (PROTitleTextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[PROTitleTextField alloc] initWithTitle:@"昵称" placeholder:@"请输入昵称"];
        mweakify(self)
        _nameTextField.textFieldDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self nameTextFieldDidChange:text];
        };
    }
    return _nameTextField;
}

- (PROTitleTextField *)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [[PROTitleTextField alloc] initWithTitle:@"邮箱" placeholder:@"请输入邮箱"];
        mweakify(self)
        _emailTextField.textFieldDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self emailTextFieldDidChange:text];
        };
    }
    return _emailTextField;
}

- (PRODotSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[PRODotSelectView alloc] init];
        _selectView.title = @"性别";
        _selectView.firstOptionTitle = @"男";
        _selectView.secondOptionTitle = @"女";
    }
    return _selectView;
}

- (PROCusButton *)jumpButton {
    if (!_jumpButton) {
        _jumpButton = [[PROCusButton alloc] init];
        [_jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
        _jumpButton.enabled = YES;
        _jumpButton.style = PROCusButtonStyleHollow;
        [_jumpButton addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpButton;
}

- (PROCusButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[PROCusButton alloc] init];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        _doneButton.enabled = NO;
        [_doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (PROBookUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PROBookUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
