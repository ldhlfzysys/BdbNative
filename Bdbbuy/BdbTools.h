//
//  BdbTools.h
//  Bdbbuy
//
//  Created by donghuan1 on 2019/12/5.
//  Copyright © 2019 bdbbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BdbTools : NSObject
@property(nonatomic,strong)NSArray *opens;
+ (BdbTools *)sharedTools;
@end

NS_ASSUME_NONNULL_END
