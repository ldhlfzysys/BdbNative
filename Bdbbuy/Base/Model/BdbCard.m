//
//  BdbCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbCard.h"
#import "BdbTableViewCell.h"

@implementation BdbCard




-(NSString *)cardClassID
{
    if (!_cardClassID) {
        _cardClassID = NSStringFromClass([BdbTableViewCell class]);
    }
    return _cardClassID;
}

@end

@implementation BdbMultiCard

-(NSMutableArray *)subcards
{
    if (_subcards == nil) {
        _subcards = [NSMutableArray array];
    }
    return _subcards;
}



@end
