//
//  PROSafeCategory.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/4.
//

#import "PROSafeCategory.h"
#import <objc/runtime.h>

void handleError(void) {
    NSCAssert(NO, @"Foundation Classs process error happen");//调试阶段应该要断言掉，然后开发者知道问题
}

@implementation NSArray (SafeProtect)

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        handleError();
        return nil;
    }
    return [self objectAtIndex:index];
}

- (id)safeFirstObject {
    if (self.count == 0) {
        handleError();
        return nil;
    }
    return self.firstObject;
}

- (id)safeLastObject {
    if (self.count == 0) {
        handleError();
        return nil;
    }
    return self.lastObject;
}

@end

@implementation NSMutableArray (SafeProtect)

- (void)safeAddObject:(id)obj {
    if (obj == nil) {
        handleError();
        return;
    }
    if (self == obj) {
        handleError();
        return;
    }
    [self addObject:obj];
}

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index {
    if (obj == nil) {
        handleError();
        return;
    }
    if (self == obj) {
        handleError();
        return;
    }
    [self insertObject:obj atIndex:index];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        handleError();
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)obj {
    if (index >= self.count || obj == nil) {
        handleError();
        return;
    }
    if (self == obj) {
        handleError();
        return;
    }
    [self replaceObjectAtIndex:index withObject:obj];
}

- (void)removeFirstObject {
    if (self.count == 0) {
        handleError();
        return;
    }
    [self removeObjectAtIndex:0];
}

@end


@implementation NSMutableDictionary (SafeProtect)

- (void)safeSetObject:(id)object forKey:(id)key {
    if (object == nil || key == nil) {
        handleError();
        return;
    }
    if (self == object) {
        handleError();
        return;
    }
    [self setObject:object forKey:key];
}

- (void)safeRemoveObjectForKey:(id)key {
    if (key == nil) {
        handleError();
        return;
    }
    [self removeObjectForKey:key];
}

@end

@implementation NSMutableSet (SafeProtect)

- (void)safeAddObject:(id)object {
    if (object == nil) {
        handleError();
        return;
    }
    if (self == object) {
        handleError();
        return;
    }
    [self addObject:object];
}

- (void)safeRemoveObject:(id)object {
    if (object == nil) {
        handleError();
        return;
    }
    [self removeObject:object];
}

@end

@implementation NSString (SafeProtect)


- (NSString *)safeStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (replacement == nil || (range.location + range.length > self.length)) {
        handleError();
        return self;
    }
    return [self stringByReplacingCharactersInRange:range withString:replacement];
}

- (NSString *)safeStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    if (replacement == nil || target == nil) {
        handleError();
        return self;
    }
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

@end

@implementation NSMutableString (SafeProtect)

- (void)safeAppendString:(NSString *)string {
    if (string == nil) {
        handleError();
        return;
    }
    [self appendString:string];
}

@end

@implementation NSNumber (SafeProtect)

- (BOOL)safeIsEqualToNumber:(NSNumber *)number {
    if (number) {
        return [self isEqualToNumber:number];
    }
    return NO;
}

@end


