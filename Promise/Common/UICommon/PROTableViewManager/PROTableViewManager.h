//
//  PROTableViewManager.h
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class PROTableViewBaseRow, PROTableViewBaseSection;

/// 通过使用本类方法，操作sections，从而管理tableview
@interface PROTableViewManager : NSObject

@property(nonatomic, weak, readonly) UITableView *tableView;

@property(nonatomic, assign) BOOL allowAutoDeselect;

@property(nonatomic, strong) NSMutableArray<PROTableViewBaseSection *> *sections;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (nullable NSIndexPath *)indexPathForRow:(PROTableViewBaseRow *)row;
- (NSInteger)indexForSection:(PROTableViewBaseSection *)section;
- (nullable __kindof PROTableViewBaseRow *)rowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable __kindof PROTableViewBaseSection *)sectionAtIndex:(NSInteger)index;



- (void)reloadTableView;
- (void)reloadRow:(PROTableViewBaseRow *)row;
- (void)reloadSection:(PROTableViewBaseSection *)section;


//section
- (void)updateWithSection:(PROTableViewBaseSection *)section atIndex:(NSInteger)index;
//
- (void)appendSection:(PROTableViewBaseSection *)section;

- (void)appendSections:(NSArray<PROTableViewBaseSection *> *)sections;
//
- (void)insertSection:(PROTableViewBaseSection *)section atIndex:(NSInteger)index;
//
- (void)deleteSection:(PROTableViewBaseSection *)section;

- (void)deleteSectionAtIndex:(NSInteger)index;

- (void)deleteAllSecions;

- (BOOL)emptySectionWithIndexPath:(NSInteger)index;
//row
- (void)updateWithRow:(PROTableViewBaseRow *)row atIndexPath:(NSIndexPath *)indexPath;

- (void)appendRow:(PROTableViewBaseRow *)row inSection:(NSInteger)section;
- (void)appendRows:(NSArray<PROTableViewBaseRow *> *)rows inSection:(NSInteger)section;

- (void)insertRow:(PROTableViewBaseRow *)row atIndexPath:(NSIndexPath *)indexPath;

- (void)deleteRow:(PROTableViewBaseRow *)row;
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;


- (BOOL)validSection:(NSInteger)section;
- (BOOL)validIndexPath:(NSIndexPath *)indexPath;

//选中cell
@property(nonatomic, copy) void (^selectedCell)(NSIndexPath *indexPath, __kindof PROTableViewBaseRow *row);
//删除cell
@property(nonatomic, copy) void (^deleteCell)(NSIndexPath *indexPath, __kindof PROTableViewBaseRow *row);
//创建cell
@property(nonatomic, copy) void (^createCell)(NSIndexPath *indexPath, __kindof PROTableViewBaseRow *row, UITableViewCell *cell);
//Scroll
@property(nonatomic, copy) void (^didScroll)(UITableView *tableView);
@property(nonatomic, copy) void (^willBeginDragging)(UITableView *tableView);
@property(nonatomic, copy) void (^didEndDragging)(UITableView *tableView, BOOL decelerate);
@property(nonatomic, copy) void (^didEndDecelerating)(UITableView *tableView);
@property(nonatomic, copy) void (^didEndScrollingAnimation)(UITableView *tableView);
@end

NS_ASSUME_NONNULL_END
