//
//  HomeDataProvider.h
//  Bdbbuy
//
//  Created by liweixi on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeDataProvider : NSObject

@property (nonatomic, copy) NSMutableDictionary *homeData;
@property (nonatomic, strong) NSArray *bannerUrls;

+ (instancetype)sharedProvider;
- (void)requestHomeDataWithCompletionBlock:(void (^)(BOOL compelet))completion;

@end

NS_ASSUME_NONNULL_END
