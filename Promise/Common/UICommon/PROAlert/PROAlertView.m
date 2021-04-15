//
//  PROAlertView.m
//  AirPayCounter
//
//  Created by Hongwei Liu on 2019/6/13.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "PROAlertView.h"
#import "PROAlertModel.h"

@interface PROAlertView ()

@property (nonatomic, strong) PROAlertModel *model;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *hLineView;
@property (nonatomic, strong) UIView *vLineView;

@property (nonatomic, strong) UIColor *titleLabelColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *messageLabelColor;
@property (nonatomic, strong) UIFont *messageFont;
@end

@implementation PROAlertView

- (instancetype)initWithModel:(PROAlertModel *)model {
    if (self = [super init]) {
        self.model = model;
        [self addSubview:self.topImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.hLineView];
        [self addSubview:self.vLineView];
        [self setupMasonry];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.messageLabel.preferredMaxLayoutWidth = self.frame.size.width - 40;

    [PROUIUtil addViewRoundCornersView:self.leftButton corners:UIRectCornerBottomLeft radius:4];
    [PROUIUtil addViewRoundCornersView:self.rightButton corners:UIRectCornerBottomRight radius:4];
    
    if ([self onlyButtonTitle] || [self haveNoTitles]) {
        [PROUIUtil addViewRoundCornersView:self.rightButton corners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:4];
        [self.rightButton setTitle:[self onlyButtonTitle] forState:UIControlStateNormal];
        [self.rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(46);
        }];
        [self.vLineView setHidden:YES];
        [self.leftButton setHidden:YES];
    }
}

#pragma mark - Event Response
- (void)leftButtonTouchUpInside:(UIButton *)sender {
    if (self.firstButtonActionBlock) {
        self.firstButtonActionBlock(sender);
    }
}

- (void)rightButtonTouchUpInside:(UIButton *)sender {
    if ([self onlyButtonTitle] || [self haveNoTitles]) {
        self.firstButtonActionBlock(sender);
    } else {
        self.secondButtonActionBlock(sender);
    }
}

#pragma mark - Public Methods
- (void)setupContainerMasonry {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)updateContainerMasonry {
    CGFloat alertHeight = [self alertViewHeightWithTitle:self.model.title message:self.model.message];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(MScreenHeight - 140);
        make.height.mas_equalTo(alertHeight);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).mas_offset(-40);
        make.height.mas_equalTo([self titleHeightWith:self.model.title]);
        make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(20);
    }];
    
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).mas_offset(-40);
        if (NULLString(self.model.title)) {
            make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(20);
        } else {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(12);
        }
        make.height.mas_equalTo([self messageHeightWith:self.model.message]);
    }];
    
}

- (CGFloat)alertViewHeightWithTitle:(NSString *)title message:(NSString *)message {
    CGFloat titleHeight = 0;
    CGFloat messageHeight = 0;
    CGFloat totalHeight = 0;
    
    titleHeight = [self titleHeightWith:title];
    messageHeight = [self messageHeightWith:message];
    totalHeight = titleHeight + messageHeight;
    if (title && message) {
        totalHeight += 56;
    } else if(title){
        totalHeight += 44;
    } else if(message){
        totalHeight += 44;
    } else {
        totalHeight += 20;
    }
    if ([self.model hasTopImage]) {
        totalHeight += self.topImageView.frame.size.width / self.model.imageRatio.floatValue;
    }
    return totalHeight + 46;
}

- (CGFloat)titleHeightWith:(NSString *)title {
    CGFloat titleHeight = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    if (!NULLString(title)) {
        NSDictionary *titleAttributes = @{NSFontAttributeName: MRegularFont(16),
        NSParagraphStyleAttributeName: paragraphStyle};
        titleHeight = [title boundingRectWithSize:CGSizeMake(MScreenHeight - 180, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:titleAttributes context:nil].size.height;
        titleHeight = ceil(titleHeight);
    }
    
    return titleHeight;
}

- (CGFloat)messageHeightWith:(NSString *)message {
    CGFloat messageHeight = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    if (!NULLString(message)) {
        NSDictionary *contentAttributes = @{NSFontAttributeName:MRegularFont(14),NSParagraphStyleAttributeName: paragraphStyle};
        messageHeight = [message boundingRectWithSize:CGSizeMake(MScreenHeight - 180, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:contentAttributes context:nil].size.height;
        messageHeight = ceil(messageHeight);
    }
    return messageHeight;
}

#pragma mark - Private Methods
- (void)setupMasonry {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(46);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(46);
    }];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        if ([self.model hasTopImage]) {
            make.height.mas_equalTo(self.topImageView.mas_width).dividedBy(self.model.imageRatio.floatValue);
        } else {
            make.height.mas_equalTo(0);
        }
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(self.mas_width).mas_offset(-40);
        make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(20);
        if (self.messageLabel.hidden) {
            make.bottom.mas_equalTo(self.rightButton.mas_top).mas_offset(-20);
        }
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        if (self.titleLabel.hidden) {
            make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(20);
        } else {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(12);
        }
        make.bottom.mas_equalTo(self.rightButton.mas_top).mas_offset(-24);
    }];
    [self.hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.rightButton.mas_top);
        make.height.mas_equalTo((2.0/[UIScreen mainScreen].scale));
    }];
    [self.vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.hLineView.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo((2.0/[UIScreen mainScreen].scale));
        make.centerX.mas_equalTo(0);
    }];
}

- (NSString *)onlyButtonTitle {
    if (self.model.firstButtonTitle.length > 0 && self.model.secondButtonTitle.length <= 0) {
        return self.model.firstButtonTitle;
    }
    if (self.model.secondButtonTitle.length > 0 && self.model.firstButtonTitle.length <= 0) {
        return self.model.secondButtonTitle;
    }
    return nil;
}

- (BOOL)haveNoTitles {
    return self.model.firstButtonTitle.length <= 0 && self.model.secondButtonTitle.length <= 0;
}

#pragma mark - Getters
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        [_topImageView setContentMode:UIViewContentModeScaleAspectFit];
        if (self.model.topImage) {
            UIImage *image = self.model.topImage;
            if (image) {
                [_topImageView setImage:image];
            }
        } else if (self.model.topImageURL) {
//            UIImage *placeholder = [APCThemeM  imageInPod:kAPCUIKitBundleName imageNamge:@"alert_vc_placeholder"];
//            mweakify(self);
//            [_topImageView sd_setImageWithURL:self.model.topImageURL placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                if (!error) {
//                    mstrongify(self);
//                    [self.topImageView setBackgroundColor:[UIColor whiteColor]];
//                }
//            }];
            [_topImageView setBackgroundColor:MCOLOR_ALPHA(@"#000000", 0.09)];
            [_topImageView setContentMode:UIViewContentModeScaleAspectFit];
        } else {
            [_topImageView setImage:nil];
        }
    }
    return _topImageView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(leftButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setTitle:self.model.firstButtonTitle forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor pro_normalTitleColor] forState:UIControlStateNormal];
        [_leftButton.titleLabel setFont:MRegularFont(16)];
        [_leftButton setHidden:self.model.firstButtonTitle.length <= 0];
        _leftButton.backgroundColor = [UIColor clearColor];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton addTarget:self action:@selector(rightButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setTitle:self.model.secondButtonTitle forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor pro_themeColor] forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:MRegularFont(16)];
        _rightButton.backgroundColor = [UIColor clearColor];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setText:self.model.title];
        [_titleLabel setFont:self.titleFont];
        [_titleLabel setTextColor:self.titleLabelColor];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleLabel.hidden = NULLString(self.model.title);
        [self.model addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        [_messageLabel setNumberOfLines:0];
        [_messageLabel setText:self.model.message];
        [_messageLabel setFont:self.messageFont];
        [_messageLabel setTextColor:self.messageLabelColor];
        [_messageLabel setTextAlignment:self.model.messageTextAlignment];
        _messageLabel.hidden = NULLString(self.model.message);
        [self.model addObserver:self forKeyPath:@"message" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _messageLabel;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSString *newValue = [change valueForKey:@"new"];
    if (object == self.model && [keyPath isEqualToString:@"title"]){
        self.titleLabel.hidden = NULLString(newValue);
    } else if (object == self.model && [keyPath isEqualToString:@"message"]){
        self.messageLabel.hidden = NULLString(newValue);
    }
}

- (UIView *)hLineView {
    if (!_hLineView) {
        _hLineView = [[UIView alloc] init];
        [_hLineView setBackgroundColor:MCOLOR_ALPHA(@"#000000",0.09)];
    }
    return _hLineView;
}

- (UIView *)vLineView {
    if (!_vLineView) {
        _vLineView = [[UIView alloc] init];
        [_vLineView setBackgroundColor:MCOLOR_ALPHA(@"#000000",0.09)];
    }
    return _vLineView;
}

- (UIColor *)titleLabelColor {
    if (!_titleLabelColor) {
        if (!NULLString(self.model.titleTextColor)) {
            _titleLabelColor = MCOLOR(self.model.titleTextColor);
        }
        if (!_titleLabelColor) {
            _titleLabelColor = [UIColor pro_normalTitleColor];
        }
    }
    
    return _titleLabelColor;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        CGFloat fontSize = self.model.titleFontSize == 0 ? 16 : self.model.titleFontSize;
        _titleFont = [self fontForSize:fontSize weight:self.model.titleFontWeight];
    }
    
    return _titleFont;
}

- (UIFont *)messageFont {
    if (!_messageFont) {
        CGFloat fontSize = self.model.messageFontSize == 0 ? 14 : self.model.messageFontSize;
        _messageFont = [self fontForSize:fontSize weight:self.model.messageFontWeight];
    }
    
    return _messageFont;
}

- (UIFont *)fontForSize:(CGFloat)size weight:(PROAlertFontWeight)weight {
    CGFloat fontSize = size == 0 ? 16 : size;
    
    switch (weight) {
        case PROAlertFontWeightBold:
            return MBoldFont(fontSize);
        case PROAlertFontWeightLight:
            return MLightFont(fontSize);
        case PROAlertFontWeightRegular:
            return MRegularFont(fontSize);
        case PROAlertFontWeightSemiBold:
            return MSemiboldFont(fontSize);
        default:
            return MMediumFont(fontSize);
    }
}

- (UIColor *)messageLabelColor {
    if (!_messageLabelColor) {
        if (!NULLString(self.model.messageTextColor)) {
            _messageLabelColor = MCOLOR(self.model.messageTextColor);
        }
        if (!_messageLabelColor) {
            _messageLabelColor = MCOLOR_ALPHA(@"#000000",0.65);
        }
    }
    
    return _messageLabelColor;
}

#pragma mark - Setter

- (void)setModel:(PROAlertModel *)model {
    if (_model != model) {
        _model = model;
        // 默认宽高比2
        if (!_model.imageRatio || _model.imageRatio.floatValue <= 0) {
            _model.imageRatio = @(2.0);
        }
    }
}
@end

