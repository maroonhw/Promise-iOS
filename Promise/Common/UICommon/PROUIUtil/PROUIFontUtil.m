//
//  PROUIFontUtil.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROUIFontUtil.h"

@implementation PROUIFontUtil

+ (UIFont *)regularFontWithSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
}

+ (UIFont *)mediumFontWithSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
}

+ (UIFont *)lightFontWithSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
}

+ (UIFont *)semiBoldFontWithSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
}

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
}

@end
