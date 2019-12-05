//
//  BdbTools.m
//  Bdbbuy
//
//  Created by donghuan1 on 2019/12/5.
//  Copyright © 2019 bdbbuy. All rights reserved.
//

#import "BdbTools.h"

@implementation BdbTools

+ (BdbTools *)sharedTools
{
    static dispatch_once_t onceToken;
    static BdbTools *tools;
    dispatch_once(&onceToken, ^{
        tools = [[BdbTools alloc] init];
    });
    return tools;
}



@end
