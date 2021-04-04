//
//  PROTableViewBaseSection.m
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import "PROTableViewBaseSection.h"
#import "PROTableViewBaseRow.h"


@interface PROTableViewBaseSection ()
@property(nonatomic, strong, readwrite) NSMutableArray<PROTableViewBaseRow *> *rows;
@end
@implementation PROTableViewBaseSection


- (instancetype)init {
    if (self = [super init]) {
        self.rows = [NSMutableArray array];
    }
    return self;
}

- (void)appendRow:(PROTableViewBaseRow *)row {
    if (!row) {
        return;
    }
    [self.rows addObject:row];
}

- (void)appendRows:(NSArray<PROTableViewBaseRow *> *)rows {
    [rows enumerateObjectsUsingBlock:^(PROTableViewBaseRow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self appendRow:obj];
    }];
}

- (void)updateWithRow:(PROTableViewBaseRow *)row atIndex:(NSInteger)index {
    if (![self validIndex:index] || !row) {
        return;
    }
    
    [self.rows replaceObjectAtIndex:index withObject:row];
}

- (void)insertRow:(PROTableViewBaseRow *)row atIndex:(NSInteger)index {
    if (![self validIndex:index]) {
           return;
       }
    [self.rows insertObject:row atIndex:index];
}

- (void)deleteRow:(PROTableViewBaseRow *)row {
    if (!row) {
        return;
    }
    [self.rows removeObject:row];
}

- (void)deleteRowAtIndex:(NSUInteger)index {
    if (![self validIndex:index]) {
        return;
    }
    
    [self.rows removeObjectAtIndex:index];
}

- (void)deleteAllRows {
    [self.rows removeAllObjects];
}

- (NSInteger)indexForRow:(PROTableViewBaseRow *)row {
    return [self.rows indexOfObject:row];
}

#pragma mark -
- (BOOL)validIndex:(NSInteger)index {
    return index >= 0 && index < self.rows.count;
}

- (CGFloat)estimatedSectionHeaderHeight {
    return  _estimatedSectionHeaderHeight > 0 ? _estimatedSectionHeaderHeight : _sectionHeaderHeight;
}

- (CGFloat)estimatedSectionFooterHeight {
    return  _estimatedSectionFooterHeight > 0 ? _estimatedSectionFooterHeight : _sectionFooterHeight;
}

@end
