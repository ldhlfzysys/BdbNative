//
//  HomeProductCollectionViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/5.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeProductCollectionViewCell.h"

@implementation HomeProductCollectionViewCell
-(instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}
@end
