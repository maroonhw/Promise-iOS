//
//  PROPROCommonDefine.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#ifndef PROCommonDefine_h
#define PROCommonDefine_h

// block安全回调
#define safe_block(block,...) \
if (block) { \
block(__VA_ARGS__); \
}

//空字符串判断
#define NULLString(string) ((string == nil) || ([string isKindOfClass:[NSNull class]]) || (![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]== 0 )

#define mweakify(val) \
m_keywordify \
m_weakify_(__weak, val)

#define m_weakify_(CONTEXT, VAR) \
CONTEXT __typeof__(VAR) VAR_weak_ = (VAR);

#define mstrongify(val) \
m_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
m_strongify_(val) \
_Pragma("clang diagnostic pop")

#define m_strongify_(VAR) \
__strong __typeof__(VAR) VAR = VAR_weak_;

#define m_keywordify

#define m_safe_call_block(block,...) \
if (block) { \
block(__VA_ARGS__); \
}

#endif /* PROCommonDefine_h */
