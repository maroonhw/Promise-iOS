//
//  PROBaseViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROBaseViewController.h"

@interface PROBaseViewController ()

@property (nonatomic, strong) UILabel *pageTitleLabel;

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation PROBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)endEditTap:(UITapGestureRecognizer*)sender {
    [self.view endEditing:YES];
}

- (void)setupSubViews {
    self.view.backgroundColor = MCOLOR(@"#44606b");
    
    if (self.needBackButton) {
        [self.view addSubview:self.backButton];
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(18);
            make.top.mas_equalTo(MStatusBarHeight + 14);
            make.height.mas_equalTo(26);
            make.width.mas_equalTo(14);
        }];
    }
    if (!NULLString(self.pageTitle)) {
        [self.view addSubview:self.pageTitleLabel];
        [self.pageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(MStatusBarHeight + 13);
        }];
    }
}


- (void)backPage {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)setPageTitle:(NSString *)pageTitle {
    self.pageTitleLabel.text = pageTitle;
}

- (UILabel *)pageTitleLabel {
    if (!_pageTitleLabel) {
        _pageTitleLabel = [[UILabel alloc]init];
        [_pageTitleLabel setFont:MMediumFont(18)];
        [_pageTitleLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.9)];
        _pageTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pageTitleLabel;
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
