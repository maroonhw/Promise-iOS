//
//  PROAvatarView.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/12.
//

#import "PROAvatarView.h"

@interface PROAvatarView ()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation PROAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView {
    [self addSubview:self.nameLabel];
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(76);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(14);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(12);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPhotoAction:)];
    [self addGestureRecognizer:tap];
}

- (void)selectPhotoAction:(UITapGestureRecognizer*)sender {
    if (self.selectPhotoComplate) {
        self.selectPhotoComplate();
    }
}


- (void)setImage:(UIImage *)image {
    if (image) {
        self.imageView.image = image;
    }
}

- (void)setTitle:(NSString *)title {
    self.nameLabel.text = title;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"check_no_hook"];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 38;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFont:MMediumFont(10)];
        _nameLabel.text = @"点击更换头像";
        [_nameLabel setTextColor:MCOLOR_ALPHA(@"#ffffff",0.4)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
