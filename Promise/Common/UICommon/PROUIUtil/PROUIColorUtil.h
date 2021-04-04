//
//  PROUIColorUtil.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define MCOLOR(colorName) getColorOrClearColor([PROUIColorUtil getColorByName:colorName])
#define MCOLOR_ALPHA(colorName,a) getColorOrClearColor([PROUIColorUtil getColorByName:colorName alpha:a])
#define MRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define MRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define MHEXCOLOR(value) [PROUIColorUtil colorWithRGBValue:value]

CG_INLINE
UIColor *getColorOrClearColor(UIColor *color) {
    if (nil == color) {
        return [UIColor clearColor];
    }
    return color;
}

@interface PROUIColorUtil : NSObject

/**
根据十六进制字符串生成颜色
 eg. #FFFFFF

 @param colorName 对应颜色字符串
 @return 对应颜色
*/
+ (UIColor *)getColorByName:(NSString *)colorName;

/**
根据十六进制字符串生成带透明通道颜色
 eg. #FFFFFF

 @param colorName 对应颜色字符串
 @param alpha 透明度
 @return 对应颜色
*/
+ (UIColor *)getColorByName:(NSString *)colorName alpha:(CGFloat)alpha;

/**
根据十六进制字符串生成颜色
 eg. #FFFFFF

 @param value 对应颜色十六进制数值
 @return 对应颜色
*/
+ (UIColor *)colorWithRGBValue:(NSInteger)value;


@end

NS_ASSUME_NONNULL_END
