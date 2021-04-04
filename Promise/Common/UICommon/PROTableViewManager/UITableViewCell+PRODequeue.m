//
//  UITableViewCell+PRODequeue.m
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import "UITableViewCell+PRODequeue.h"


@implementation UITableViewCell (PRODequeue)

+ (void)registerToTableView:(UITableView *)tableView {
    if (![self isSubclassOfClass:UITableViewCell.class]) {
        return;
    }
    
    [tableView registerClass:self forCellReuseIdentifier:self.reuseIdentifier];
}

+ (__kindof UITableViewCell *)dequeueForTableView:(UITableView *)tableView {
    return [self dequeueForTableView:tableView forIndexPath:nil];
}

+ (__kindof UITableViewCell *)dequeueForTableView:(UITableView *)tableView forIndexPath:(NSIndexPath  * _Nullable)indexPath {
    NSString *reuseIdentifier = self.reuseIdentifier;
    
    UITableViewCell *cell = nil;
    
    if (indexPath) {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    }
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    return cell;
}


+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

@end
