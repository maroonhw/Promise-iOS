//
//  PROTitleTextField.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PROTitleTextField.h"

@interface PROTitleTextField ()

@property(nonatomic, strong) UITextField *textField;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation PROTitleTextField

- (instancetype)init {
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


- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    self = [self init];
    if (self) {
        self.title = title;
        self.placeholder = placeholder;
    }
    return self;
}


- (void)setupView {
    [self addSubview:self.textField];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(42);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(12);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
    }];
}

- (void)textFileldDidChange:(NSNotification *)notification {
    if (notification.object != self.textField) {
        return;
    }
    if (self.textFieldDidChangeHandler) {
        self.textFieldDidChangeHandler(self.textField.text);
    }
    
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder
                                                                     attributes:@{
                                                                         NSForegroundColorAttributeName:MCOLOR_ALPHA(@"#ffffff", 0.3),
                                                                         NSFontAttributeName:MRegularFont(18)
                                                                     }];
    _textField.attributedPlaceholder = attrString;
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


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:MMediumFont(18)];
        [_titleLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.4)];
    }
    return _titleLabel;
}

@end
