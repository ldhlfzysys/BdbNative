//
//  BdbCard.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BdbCard : NSObject
@property (nonatomic, copy) NSString *cardClassID; // cell的Identifier
@property (nonatomic, assign) NSInteger cardHeight; // cell的高度

@end


@interface BdbMultiCard : BdbCard
@property (nonatomic, strong) NSMutableArray<BdbCard *> *subcards;
@end

NS_ASSUME_NONNULL_END
