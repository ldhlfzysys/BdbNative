//
//  BdbCardTableViewCell.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/3.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbTableViewCell.h"
#import "BdbCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface BdbCardTableViewCell : BdbTableViewCell
@property (nonatomic, weak) BdbCard *cellCard;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellCard:(BdbCard *)cellCard;
@end

NS_ASSUME_NONNULL_END
