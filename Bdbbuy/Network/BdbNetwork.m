//
//  BdbNetwork.m
//  Bdbbuy
//
//  Created by liweixi on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbNetwork.h"
#import "AFNetworking.h"


NSString *const BdbBaseURL = @"https://bdbbuy.com/";
//NSString *const BdbBaseURL = @"http://localhost:1118/";
static NSTimeInterval BdbTimeout = 60;

@implementation BdbNetwork

#pragma MARK - Public
- (instancetype)initWithBaseURL:(NSString *)baseURL
{
    BdbNetwork *instance = [[BdbNetwork alloc] init];
    instance.baseURL = baseURL;
    return instance;
}

static BdbNetwork *network = nil;
+ (instancetype)sharedNetwork
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[BdbNetwork alloc] initWithBaseURL:BdbBaseURL];
    });
    
    return network;
}

- (void)loadHomeData:(void (^)(BOOL success, NSURLSessionDataTask * _Nonnull task, id result, NSError * error))completion
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", self.baseURL, @"categoryapi/category"];
    [[AFHTTPSessionManager manager] GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion) {
            completion(YES, task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO, task, nil, error);
        }
    }];
}

- (void)loadCategoryData:(void (^)(BOOL success, NSURLSessionDataTask * _Nonnull task, id result, NSError * error))completion
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", self.baseURL, @"api/index"];
    [[AFHTTPSessionManager manager] GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion) {
            completion(YES, task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO, task, nil, error);
        }
    }];
}

- (void)sendGetRequestWithPath:(NSString *)path WithParam:(nullable NSDictionary *)paramDic compeletion:(void (^)(BOOL success, NSURLSessionDataTask * _Nonnull task, id result, NSError * error))completion
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", self.baseURL, path];
    [[AFHTTPSessionManager manager] GET:URL parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion) {
            completion(YES, task, responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO, task, nil, error);
        }
    }];
}


- (void)sendPostRequestWithPath:(NSString *)path WithParam:(nullable NSDictionary *)paramDic compeletion:(void (^)(BOOL success, NSURLSessionDataTask * _Nonnull task, NSDictionary * result, NSError * error))completion
{
    NSString *URL = [NSString stringWithFormat:@"%@%@", self.baseURL, path];
    NSLog(@"发起Post请求地址:%@", URL);
    [[AFHTTPSessionManager manager] POST:URL parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(YES, task, (NSDictionary *)responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO, task, nil, error);
        }
    }];
}


@end
