//
//  HomeProductCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/5.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeProductCell.h"
#import "BdbSegmentMenu.h"
#import "HomeProductController.h"

@interface HomeProductCell ()
@property (nonatomic, strong) NSMutableArray * segmentVCs;
@end

@implementation HomeProductCell
{
    BdbSegmentMenu *_segmentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellCard:(nonnull BdbCard *)cellCard
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellCard:cellCard];
    if (self) {
        _segmentVCs = [NSMutableArray array];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (!_segmentView) {
        HomeProductController *vc1 = [[HomeProductController alloc] init];
        vc1.view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self.segmentVCs addObject:vc1];
        
        HomeProductController *vc2 = [[HomeProductController alloc] init];
        vc2.view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self.segmentVCs addObject:vc2];
        
        HomeProductController *vc3 = [[HomeProductController alloc] init];
        vc3.view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self.segmentVCs addObject:vc3];
        
        HomeProductController *vc4 = [[HomeProductController alloc] init];
        vc4.view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self.segmentVCs addObject:vc4];
        
        HomeProductController *vc5 = [[HomeProductController alloc] init];
        vc5.view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
        [self.segmentVCs addObject:vc5];
        
        BdbSegmentMenu *segment = [[BdbSegmentMenu alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 1000) ControllerViewArray:@[vc1.view, vc2.view, vc3.view, vc4.view, vc5.view] TitleArray:@[@"特色推荐", @"生鲜水果", @"网红零食", @"测试代码", @"测试代码"]];
        
        _segmentView = segment;
        [self.contentView addSubview:segment];
    }
    
}
@end
