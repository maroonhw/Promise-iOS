//
//  PROTableViewBaseRow.h
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/// cell model 的基类，不建议直接使用，需要继承
@interface PROTableViewBaseRow : NSObject
//cell对应的class，不能为空
@property(nonatomic, strong) Class _Nonnull cellClass;
//高度，外部计算后传入
@property(nonatomic, assign) CGFloat height;
//暂时未使用、未实现，在之后会扩展,目前使用的还是 height
@property(nonatomic, assign) CGFloat estimatedHeight;
//cell是否可以编辑
@property(nonatomic, assign) BOOL canEdit;
//左滑删除的文案
@property(nonatomic, copy) NSString  *leftDeleteText;
//cell的点击事件，目前未实现，可以使用PROTableViewManager中的selectedCell
@property(nonatomic, copy) void(^onSelected)(NSIndexPath *indexPath, PROTableViewBaseRow *row);
//区分cell类型
@property(nonatomic, assign) NSInteger businessType;
@end

NS_ASSUME_NONNULL_END
