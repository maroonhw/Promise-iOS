//
//  PROUIFontUtil.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//字体定义
#define MRegularFont(size)   [PROUIFontUtil regularFontWithSize:size]
#define MMediumFont(size)    [PROUIFontUtil mediumFontWithSize:size]
#define MLightFont(size)     [PROUIFontUtil lightFontWithSize:size]
#define MSemiboldFont(size)  [PROUIFontUtil semiBoldFontWithSize:size]
#define MBoldFont(size)      [PROUIFontUtil boldFontWithSize:size]

@interface PROUIFontUtil : NSObject

+ (UIFont *)regularFontWithSize:(CGFloat)fontSize;

+ (UIFont *)mediumFontWithSize:(CGFloat)fontSize;

+ (UIFont *)lightFontWithSize:(CGFloat)fontSize;

+ (UIFont *)semiBoldFontWithSize:(CGFloat)fontSize;

+ (UIFont *)boldFontWithSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
