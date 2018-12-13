//
//  BdbNetwork.h
//  Bdbbuy
//
//  Created by liweixi on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BdbNetworkRequestType) {
    BdbNetworkRequestTypeGET,
    BdbNetworkRequestTypePOST,
};

UIKIT_EXTERN NSString * const BdbBaseURL;

@interface BdbNetwork : NSObject

@property (nonatomic, copy) NSString * baseURL;


+ (instancetype)sharedNetwork;
+ (void)sendRequestWithType:(BdbNetworkRequestType)requestType WithPath:(NSString *)path WithParam:(nullable NSDictionary * ) paramDic compeletion:(void (^)(BOOL success, NSURLSessionDataTask * _Nonnull task, id resultDic, NSError * error))completion;
- (instancetype)initWithBaseURL:(NSString *)baseURL;
- (void)sendGetRequestWithPath:(NSString *)path WithParam:(nullable NSDictionary *)paramDic compeletion:(void (^)(BOOL success, NSURLSessionDataTask * _Nonnull task, id resultDic, NSError * error))completion;

@end

NS_ASSUME_NONNULL_END
