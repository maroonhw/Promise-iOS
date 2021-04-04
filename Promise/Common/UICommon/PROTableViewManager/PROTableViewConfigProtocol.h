//
//  PROTableViewConfigProtocol.h
//  vn
//
//  Created by HongweiLiu on 9.3.20.
//  Copyright © 2020 hongweiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// cell 对应的协议，通过实现cellConfig方法配置cell上的文案等（不可以在cell model中实现）
@protocol PROTableViewConfigProtocol <NSObject>
- (void)cellConfig:(id)element;

@end

NS_ASSUME_NONNULL_END
