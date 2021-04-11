//
//  NSObject+PROColorStyle.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "NSObject+PROColorStyle.h"

@implementation NSObject (PROColorStyle)

+ (UIColor *)apc_themeColor {
    return  [PROUIColorUtil getColorByName:@"#44606b"];
}


+ (UIColor *)apc_backgroundColor {
    return [PROUIColorUtil getColorByName:@"#F5F5F5"];
}


+ (UIColor *)apc_normalTitleColor {
    return [PROUIColorUtil getColorByName:@"#000000" alpha:0.87];
}

@end
