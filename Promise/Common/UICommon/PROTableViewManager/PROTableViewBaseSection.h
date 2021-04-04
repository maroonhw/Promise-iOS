//
//  PROTableViewBaseSection.h
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@class PROTableViewBaseRow;

/// Section model
@interface PROTableViewBaseSection : NSObject
//存放cell对应的model
@property(nonatomic, strong, readonly) NSMutableArray<PROTableViewBaseRow *> *rows;
//暂未实现不可使用
@property(nonatomic, assign) CGFloat sectionHeaderHeight;
//暂未实现不可使用
@property(nonatomic, assign) CGFloat estimatedSectionHeaderHeight;
//暂未实现不可使用
@property(nonatomic, strong) Class sectionHeaderClass;
//暂未实现不可使用
@property(nonatomic, assign) CGFloat sectionFooterHeight;
//暂未实现不可使用
@property(nonatomic, assign) CGFloat estimatedSectionFooterHeight;
//暂未实现不可使用
@property(nonatomic, strong) Class sectionFooterClass;

- (void)appendRow:(PROTableViewBaseRow *)row;
- (void)appendRows:(NSArray<PROTableViewBaseRow *> *)rows;

- (void)updateWithRow:(PROTableViewBaseRow *)row atIndex:(NSInteger)index;

- (void)insertRow:(PROTableViewBaseRow *)row atIndex:(NSInteger)index;

- (void)deleteRow:(PROTableViewBaseRow *)row;
- (void)deleteRowAtIndex:(NSUInteger)index;
- (void)deleteAllRows ;

- (NSInteger)indexForRow:(PROTableViewBaseRow *)row;



@end

NS_ASSUME_NONNULL_END
