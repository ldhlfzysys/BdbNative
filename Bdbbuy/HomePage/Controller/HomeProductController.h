//
//  HomeProductController.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/5.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeProductController : BaseViewController
@property (nonatomic, copy) NSMutableDictionary *dataDic;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
