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
#warning test
    [self mockData];
    completion(YES);
    
//    [BdbNetwork sendRequestWithType:BdbNetworkRequestTypeGET WithPath:@"api" WithParam:nil compeletion:^(BOOL success, NSURLSessionDataTask * _Nonnull task, id result, NSError * _Nonnull error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if (success) {
//            NSArray *homeData = (NSArray *)result;
//            strongSelf.homeData = homeData;
//            for (NSDictionary *dic in homeData) {
//                int type = [dic[@"type"] intValue];
//                switch (type) {
//                    case 1:
//                        strongSelf.bannerUrls = dic[@"data"];
//                        break;
//                    case 2:
//                        strongSelf.catogeryInfos = dic[@"data"];
//                        break;
//                    case 3:
//
//                        break;
//                    default:
//                        break;
//                }
//            }
//
//            completion(YES);
//        }
//    }];
}


- (void)mockData
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"homedatamock" ofType:@"json"];
    NSArray *resultArr = nil;
    if (path) {
        NSInputStream *inputstream = [NSInputStream inputStreamWithFileAtPath:path];
        [inputstream open];
        resultArr = [NSJSONSerialization JSONObjectWithStream:inputstream options:NSJSONReadingAllowFragments error:nil];
        [inputstream close];
    }
    self.homeData = resultArr;
}


@end
