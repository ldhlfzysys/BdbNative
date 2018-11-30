//
//  HomeDataProvider.m
//  Bdbbuy
//
//  Created by liweixi on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeDataProvider.h"
#import "BdbNetwork.h"

@implementation HomeDataProvider

static HomeDataProvider * provider = nil;
+ (instancetype)sharedProvider
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        provider = [[self alloc] init];
    });
    return provider;
}


@end
