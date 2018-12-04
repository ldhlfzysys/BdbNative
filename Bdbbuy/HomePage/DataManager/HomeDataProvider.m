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

- (void)requestHomeDataWithCompletionBlock:(void (^)(BOOL compelet))completion
{
    __weak typeof(self) weakSelf = self;
    [BdbNetwork sendRequestWithType:BdbNetworkRequestTypeGET WithPath:@"api" WithParam:nil compeletion:^(BOOL success, NSURLSessionDataTask * _Nonnull task, id result, NSError * _Nonnull error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (success) {
            NSArray *homeData = (NSArray *)result;
            strongSelf.bannerUrls = homeData[0][@"data"];
            completion(YES);
        }
    }];
}


@end
