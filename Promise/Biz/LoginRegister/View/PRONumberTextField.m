//
//  PRONumberTextField.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/10.
//

#import "PRONumberTextField.h"

@interface PRONumberTextField ()
@property(nonatomic, strong) UITextField *textField;

@property(nonatomic, strong) UIView *custRightView;

@property(nonatomic, strong) UIImageView *custRightImageView;

@property(nonatomic, strong) UIView *bottomView;

@property(nonatomic, assign) BOOL showPassword;

@end

@implementation PRONumberTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFileldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView {
    [self addSubview:self.textField];
    [self addSubview:self.bottomView];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-1);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePasswordStatus)];
    [self.custRightView addGestureRecognizer:recognizer];
}

- (void)changePasswordStatus {
    self.showPassword = !self.showPassword;
    self.textField.secureTextEntry = self.showPassword;
}


- (void)textFileldDidChange:(NSNotification *)notification {
    if (notification.object != self.textField) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(numberTextField:text:)]) {
        [self.delegate numberTextField:self text:self.textField.text];
    }
    
    if (self.textDidChangeHandler) {
        self.textDidChangeHandler(self.textField.text);
    }
    
}

-(void)setPlaceholder:(NSString *)placeholder {
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder
                                                                     attributes:@{
                                                                         NSForegroundColorAttributeName:MCOLOR_ALPHA(@"#ffffff", 0.3),
                                                                         NSFontAttributeName:MRegularFont(18)
                                                                     }];
    _textField.attributedPlaceholder = attrString;
}


-(void)setClearsOnBeginEditing:(BOOL)clearsOnBeginEditing {
    self.textField.clearsOnBeginEditing = clearsOnBeginEditing;

}

- (void)setShowPassword:(BOOL)showPassword {
    _showPassword = showPassword;
    UIImage *image = nil;
    if (_showPassword) {
        image = [UIImage imageNamed:@"eyes_closed"];
    } else {
        image = [UIImage imageNamed:@"eyes_open"];
    }
    self.custRightImageView.image = image;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    self.textField.secureTextEntry = secureTextEntry;
    if (secureTextEntry) {
        self.textField.rightView = self.custRightView;
    }
}

- (UIView *)custRightView {
    if (!_custRightView) {
        _custRightView = [[UIView alloc] init];
        [self.custRightImageView sizeToFit];
        [_custRightView addSubview:self.custRightImageView];
        _custRightView.frame = CGRectMake(0, 0, self.custRightImageView.bounds.size.width, self.custRightImageView.bounds.size.height);
    }
    
    return _custRightView;
}

- (UIImageView *)custRightImageView {
    if (!_custRightImageView) {
        _custRightImageView = [[UIImageView alloc] init];
        _custRightImageView.image = [UIImage imageNamed:@"eyes_closed"];
    }
    return _custRightImageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.smartInsertDeleteType = UITextSmartInsertDeleteTypeYes;
        _textField.font = MRegularFont(18);
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.tintColor = MCOLOR(@"#ffffff");
        _textField.textColor = MCOLOR(@"#ffffff");
        _textField.clearButtonMode = UITextFieldViewModeNever;
        _textField.secureTextEntry = NO;
    }
    return _textField;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = MCOLOR_ALPHA(@"#ffffff",0.06);
    }
    return _bottomView;
}

@end
