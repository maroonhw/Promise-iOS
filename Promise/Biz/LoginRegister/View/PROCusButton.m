//
//  PROCusButton.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PROCusButton.h"

@implementation PROCusButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initStyle];
    }
    return self;
}

- (void)initStyle {
    self.backgroundColor = MCOLOR_ALPHA(@"#ffffff",0.1);
    self.layer.cornerRadius = 25;
    [self.titleLabel setFont:MRegularFont(16)];
    [self setTitleColor:MCOLOR(@"#ffffff") forState:UIControlStateNormal];
}

- (void)setStyle:(PROCusButtonStyle)style {
    _style = style;
    if (style == PROCusButtonStyleHollow) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = MCOLOR_ALPHA(@"#ffffff", 0.3).CGColor;
        self.layer.borderWidth = 1;
        [self setTitleColor:MCOLOR_ALPHA(@"#ffffff", 0.8) forState:UIControlStateNormal];
    }
}

- (void)updateCusButtonStatus:(BOOL)enabled {
    self.enabled = enabled;
    if (self.enabled) {
        [self setTitleColor:MCOLOR(@"#44606b") forState:UIControlStateNormal];
        self.backgroundColor = MCOLOR(@"#e0d4c6");
    } else {
        [self setTitleColor:MCOLOR(@"#ffffff") forState:UIControlStateNormal];
    }
}

@end
