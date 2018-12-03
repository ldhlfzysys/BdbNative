//
//  HomeCatogeryTableViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeCatogeryTableViewCell.h"
#import "MultiButtonsView.h"

@implementation HomeCatogeryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.cellCard.cardHeight;
    NSArray<ButtonInfo *> *buttonInfoArr = [self.cellCard.dataDic objectForKey:@"data"];
    int maxLineCount = [self.cellCard.dataDic[@"maxLineCount"] intValue];
    
    MultiButtonsView *multiButtonView = [[MultiButtonsView alloc] initWithFrame:CGRectMake(0,0,self.contentView.width,height) WithButtonInfos:buttonInfoArr  WithMaxLineCount:maxLineCount];

    [self.contentView addSubview:multiButtonView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
