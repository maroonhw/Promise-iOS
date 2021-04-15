//
//  PROAlertModel.m
//  AirPayCounter
//
//  Created by Hongwei Liu on 2019/4/22.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "PROAlertModel.h"

@implementation PROAlertActionModel

@end

@implementation PROAlertModel

- (BOOL)hasTopImage {
    return self.topImage || self.topImageURL;
}

- (PROAlertFontWeight)titleFontWeight {
    if (_titleFontWeight == PROAlertFontWeightUnknown) {
        _titleFontWeight = PROAlertFontWeightMedium;
    }
    return _titleFontWeight;
}

- (PROAlertFontWeight)messageFontWeight {
    if (_messageFontWeight == PROAlertFontWeightUnknown) {
        _messageFontWeight = PROAlertFontWeightRegular;
    }
    return _messageFontWeight;
}

@end
