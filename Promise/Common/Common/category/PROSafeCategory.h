//
//  PROSafeCategory.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (SafeProtect)

- (ObjectType)safeObjectAtIndex:(NSUInteger)index;

- (ObjectType)safeFirstObject;

- (ObjectType)safeLastObject;

@end


@interface NSMutableArray<ObjectType> (SafeProtect)

- (void)removeFirstObject;

- (void)safeAddObject:(ObjectType)obj;

- (void)safeInsertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

@end


@interface NSMutableDictionary<KeyType, ObjectType> (SafeProtect)

- (void)safeSetObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

- (void)safeRemoveObjectForKey:(KeyType)aKey;

@end


@interface NSMutableSet<ObjectType> (SafeProtect)

- (void)safeAddObject:(ObjectType)object;

- (void)safeRemoveObject:(ObjectType)object;

@end


@interface NSMutableString (SafeProtect)

- (void)safeAppendString:(NSString *)aString;

@end

@interface NSString (SafeProtect)

- (NSString *)safeStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;

- (NSString *)safeStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement;


@end

@interface NSNumber (SafeProtect)

- (BOOL)safeIsEqualToNumber:(NSNumber *)number;

@end


NS_ASSUME_NONNULL_END
