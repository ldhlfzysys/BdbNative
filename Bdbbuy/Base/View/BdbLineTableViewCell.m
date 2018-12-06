//
//  BdbLineTableViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/5.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbLineTableViewCell.h"

@implementation BdbLineTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return self;
}
@end
