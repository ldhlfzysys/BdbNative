//
//  BdbCardProtocol.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BdbCardProtocol <NSObject>

@required
- (UIView *)viewWithCardData:(NSDictionary *)data;
- (void)refreshView:(UIView *)view WithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
