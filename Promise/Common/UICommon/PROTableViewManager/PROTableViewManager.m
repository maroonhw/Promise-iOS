//
//  PROTableViewManager.m
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import "PROTableViewManager.h"
#import "PROTableViewBaseRow.h"
#import "PROTableViewBaseSection.h"
#import "PROTableViewConfigProtocol.h"
#import "UITableViewCell+PRODequeue.h"

@interface PROTableViewManager() <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak, readwrite) UITableView *tableView;
@end

@implementation PROTableViewManager

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.sections = [NSMutableArray array];
        self.allowAutoDeselect = YES;
    }
    return self;
}

#pragma mark - get index
- (NSIndexPath *)indexPathForRow:(PROTableViewBaseRow *)row {
    for (NSInteger s = 0; s < self.sections.count; ++s) {
        PROTableViewBaseSection *section = self.sections[s];
        for (NSInteger r = 0; r < section.rows.count ; ++r) {
            if (row == section.rows[r]) {
                return [NSIndexPath indexPathForRow:r inSection:s];
            }
        }
    }
    return nil;
}

- (NSInteger)indexForSection:(PROTableViewBaseSection *)section {
    for (NSInteger s = 0; s < self.sections.count; ++s) {
        if (section == self.sections[s]) {
            return s;
        }
    }
    return NSNotFound;
}

- (BOOL)emptySectionWithIndexPath:(NSInteger)index {
    if ([self validSection:index]) {
        PROTableViewBaseSection *section = self.sections[index];
        if (section.rows.count <= 0) {
            return YES;
        }
        return NO;
    }
    
    return YES;
}

#pragma mark - get row and section
- (PROTableViewBaseRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self validIndexPath:indexPath]) {
        return nil;
    }
    return self.sections[indexPath.section].rows[indexPath.row];
}

- (PROTableViewBaseSection *)sectionAtIndex:(NSInteger)index {
    if (![self validSection:index]) {
        return nil;
    }
    return self.sections[index];
}


#pragma mark - reload
- (void)reloadTableView {
    [self performInSafeMainThread:^{
        [self.tableView reloadData];
    }];
}

- (void)reloadRow:(PROTableViewBaseRow *)row {
    NSIndexPath *indexPath = [self indexPathForRow:row];
    [self performInSafeMainThread:^{
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (void)reloadSection:(PROTableViewBaseSection *)section {
    NSInteger index = [self indexForSection:section];
    [self performInSafeMainThread:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

#pragma mark - Section
- (void)updateWithSection:(PROTableViewBaseSection *)section atIndex:(NSInteger)index {
    if (![self validSection:index]) {
        return;
    }
    [self.sections replaceObjectAtIndex:index withObject:section];
}

- (void)appendSection:(PROTableViewBaseSection *)section {
    [self insertSection:section atIndex:self.sections.count];
}

- (void)appendSections:(NSArray<PROTableViewBaseSection *> *)sections {
    
    [sections enumerateObjectsUsingBlock:^(PROTableViewBaseSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self appendSection:obj];
    }];
}

- (void)insertSection:(PROTableViewBaseSection *)section atIndex:(NSInteger)index {
    if (index < 0 && index > self.sections.count) {
        return;
    }
    
    [self.sections insertObject:section atIndex:index];
}

- (void)deleteSection:(PROTableViewBaseSection *)section {
    [self deleteSectionAtIndex:[self.sections indexOfObject:section]];
}

- (void)deleteSectionAtIndex:(NSInteger)index {
    if (![self validSection:index]) {
        return;
    }
    
    [self.sections removeObjectAtIndex:index];
}


- (void)deleteAllSecions {
    
    [self.sections removeAllObjects];
}


#pragma mark - row
- (void)appendRow:(PROTableViewBaseRow *)row inSection:(NSInteger)section {
    if (![self validSection:section] || !row) {
        return;
    }
    [self.sections[section] appendRow:row];
}

- (void)appendRows:(NSArray<PROTableViewBaseRow *> *)rows inSection:(NSInteger)section {
    
    [rows enumerateObjectsUsingBlock:^(PROTableViewBaseRow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self appendRow:obj inSection:section];
    }];
}

- (void)updateWithRow:(PROTableViewBaseRow *)row atIndexPath:(NSIndexPath *)indexPath {
    if (![self validSection:indexPath.section]) {
        return;
    }
    
    [self.sections[indexPath.section] updateWithRow:row atIndex:indexPath.row];
}

- (void)insertRow:(PROTableViewBaseRow *)row atIndexPath:(NSIndexPath *)indexPath {
    if (![self validIndexPath:indexPath]) {
        return;
    }
    
    [self.sections[indexPath.section] insertRow:row atIndex:indexPath.row];
}

- (void)deleteRow:(PROTableViewBaseRow *)row {
    if (!row) {
        return;
    }
    NSIndexPath *indexPath = [self indexPathForRow:row];
    [self deleteRowAtIndexPath:indexPath];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self validIndexPath:indexPath]) {
        return;
    }
    [self.sections[indexPath.section] deleteRowAtIndex:indexPath.row];
}

#pragma mark - valid
- (BOOL)validSection:(NSInteger)section {
    return section >= 0 && section < self.sections.count;
}

- (BOOL)validIndexPath:(NSIndexPath *)indexPath {
    if (indexPath && [self validSection:indexPath.section]) {
        NSInteger rowCount = self.sections[indexPath.section].rows.count;
        return indexPath.row >= 0 && indexPath.row < rowCount;
    }
    return NO;
}


- (void)performInSafeMainThread:(void(^)(void))block {
    if (block == nil) {
        return;
    }
    
    if ([NSThread currentThread].isMainThread) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}


#pragma mark - table delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self sectionAtIndex:section].rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self rowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PROTableViewBaseRow *row = [self rowAtIndexPath:indexPath];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    UITableViewCell<PROTableViewConfigProtocol> *cell = [row.cellClass dequeueForTableView:tableView];
#pragma clang diagnostic pop
    
    if ([cell conformsToProtocol:@protocol(PROTableViewConfigProtocol)]) {
        [cell cellConfig:row];
    }
    if (self.createCell) {
        self.createCell(indexPath,row,cell);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.allowAutoDeselect) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    PROTableViewBaseRow *row = [self rowAtIndexPath:indexPath];
    
    if (row && row.onSelected) {
        row.onSelected(indexPath, row);
    }
    else if (row && self.selectedCell) {
        self.selectedCell(indexPath, row);
    }
}
 
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       PROTableViewBaseRow *row = [self rowAtIndexPath:indexPath];
        if (row && self.deleteCell) {
            self.deleteCell(indexPath, row);
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    PROTableViewBaseRow *row = [self rowAtIndexPath:indexPath];
    if (row && row.canEdit) {
        return YES;
    }
    
    return NO;
}

 
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    PROTableViewBaseRow *row = [self rowAtIndexPath:indexPath];
    return row.leftDeleteText;
}



//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PROTableViewBaseRow *row = [self rowAtIndexPath:indexPath];
//
//    NSMutableArray *actions = [NSMutableArray arrayWithCapacity:row.swipeItems.count];
//    for (SSPTableRowSwipeItem *item in row.swipeItems) {
//        UITableViewRowAction *action = [UITableViewRowAction
//                                        rowActionWithStyle:UITableViewRowActionStyleNormal
//                                        title:item.title
//                                        handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                                            if (self.deleteCell) {
//                                                self.deleteCell(indexPath);
//                                            }
//                                        }];
//        action.backgroundColor = item.backgroundColor;
//        if (action) {
//            [actions addObject:action];
//        }
//    }
//
//    return actions;
//}

#pragma mark - scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.didEndDecelerating) {
        self.didEndDecelerating(self.tableView);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.didEndScrollingAnimation) {
        self.didEndScrollingAnimation(self.tableView);
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.didScroll) {
        self.didScroll(self.tableView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.willBeginDragging) {
        self.willBeginDragging(self.tableView);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.didEndDragging) {
        self.didEndDragging(self.tableView, decelerate);
    }
}

@end
