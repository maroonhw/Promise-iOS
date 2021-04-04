//
//  UITableViewCell+PRODequeue.h
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 注册生成cell，目前在PROTableViewManager使用dequeueForTableView
@interface UITableViewCell (PRODequeue)
+ (void)registerToTableView:(UITableView *)tableView;

+ (__kindof UITableViewCell *)dequeueForTableView:(UITableView *)tableView;

+ (__kindof UITableViewCell *)dequeueForTableView:(UITableView *)tableView forIndexPath:(NSIndexPath  * _Nullable)indexPath;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
