//
//  NSObject+PROColorStyle.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PROColorStyle)

/// 获取主题色，默认：1492FD
+ (UIColor *)pro_themeColor;

/// 背景色，默认：F5F5F5
+ (UIColor *)pro_backgroundColor;

/// 正常字体色，MCOLOR_ALPHA(@"#000000", 0.87)
+ (UIColor *)pro_normalTitleColor;

@end

NS_ASSUME_NONNULL_END
