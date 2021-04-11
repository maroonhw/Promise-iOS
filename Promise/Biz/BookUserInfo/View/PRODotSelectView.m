//
//  PRODotSelectView.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PRODotSelectView.h"

@interface PRODotSelectView ()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *firstLabel;

@property(nonatomic, strong) UIImageView *firstImageView;

@property(nonatomic, strong) UILabel *secondLabel;

@property(nonatomic, strong) UIImageView *secondImageView;

@end

@implementation PRODotSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.firstLabel];
    [self addSubview:self.firstImageView];
    [self addSubview:self.secondLabel];
    [self addSubview:self.secondImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(42);
    }];
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(12);;
        make.centerY.equalTo(self);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstImageView.mas_right).offset(4);;
        make.centerY.equalTo(self);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstLabel.mas_right).offset(24);;
        make.centerY.equalTo(self);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondImageView.mas_right).offset(4);;
        make.centerY.equalTo(self);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstOptionAction:)];
    [self.firstImageView addGestureRecognizer:firstTap];
    
    UITapGestureRecognizer *secondTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondOptionAction:)];
    [self.secondImageView addGestureRecognizer:secondTap];
}

- (void)firstOptionAction:(UITapGestureRecognizer*)sender {
    self.option = PRODotSelectViewOptionFirst;
}

- (void)secondOptionAction:(UITapGestureRecognizer*)sender {
    self.option = PRODotSelectViewOptionSecond;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setFirstOptionTitle:(NSString *)firstOptionTitle {
    _firstOptionTitle = firstOptionTitle;
    self.firstLabel.text = firstOptionTitle;
}

- (void)setOption:(PRODotSelectViewOption)option {
    _option = option;
    if (option == PRODotSelectViewOptionSecond) {
        self.secondImageView.image = [UIImage imageNamed:@"check_hook"];
        self.firstImageView.image = [UIImage imageNamed:@"check_no_hook"];
        [self.firstLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.4)];
        [self.secondLabel setTextColor:MCOLOR(@"#ffffff")];
    } else {
        self.secondImageView.image = [UIImage imageNamed:@"check_no_hook"];
        self.firstImageView.image = [UIImage imageNamed:@"check_hook"];
        [self.firstLabel setTextColor:MCOLOR(@"#ffffff")];
        [self.secondLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.4)];
    }
}

- (void)setSecondOptionTitle:(NSString *)secondOptionTitle {
    _secondOptionTitle = secondOptionTitle;
    self.secondLabel.text = secondOptionTitle;
}

- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] init];
        _firstImageView.image = [UIImage imageNamed:@"check_hook"];
        _firstImageView.userInteractionEnabled = YES;
    }
    return _firstImageView;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc] init];
        _secondImageView.image = [UIImage imageNamed:@"check_no_hook"];
        _secondImageView.userInteractionEnabled = YES;
    }
    return _secondImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:MMediumFont(18)];
        [_titleLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.4)];
    }
    return _titleLabel;
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc]init];
        [_firstLabel setFont:MMediumFont(18)];
        [_firstLabel setTextColor:MCOLOR(@"#ffffff")];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc]init];
        [_secondLabel setFont:MMediumFont(18)];
        [_secondLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.4)];
    }
    return _secondLabel;
}

@end
