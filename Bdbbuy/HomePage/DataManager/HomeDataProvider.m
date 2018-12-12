//
//  HomeDataProvider.m
//  Bdbbuy
//
//  Created by liweixi on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeDataProvider.h"
#import "BdbNetwork.h"

static NSString *homeDataCacheFileName = @"homedata.plist";

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
            strongSelf.homeData = homeData;
            [strongSelf saveDataTocache:homeData];
            completion(YES);
        }
    }];
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


- (void)saveDataTocache:(NSArray *)dataArr
{
    [NSKeyedArchiver archiveRootObject:dataArr toFile:[self getCatcheFileName]];
}

- (void)loadCacheDataWithCompletionBlock:(void (^)(BOOL compelet))completion
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self getCatcheFileName]]) {
        self.homeData = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCatcheFileName]];
        completion(YES);
    } else
    {
        completion(NO);
    }
    
    
}

- (NSString *)getCatcheFileName
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = array[0];
    NSString *filePathName = [cachePath stringByAppendingPathComponent:homeDataCacheFileName];
    return filePathName;
}

@end
