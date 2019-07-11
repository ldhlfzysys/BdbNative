

#import "BdbHomeCategoryCell.h"


@interface BdbHomeCategoryCell ()
@property (nonatomic, strong) BdbHomeCellTitleView *titleView;
@property (nonatomic, strong) UIImageView *sortImage;
@property (nonatomic, strong) BdbHomeCellGoodsView *goodsView;
@end

@implementation BdbHomeCategoryCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _titleView = [[BdbHomeCellTitleView alloc]init];
        [self addSubview:_titleView];
        _sortImage = [[UIImageView alloc]init];
        [self addSubview:_sortImage];
        _goodsView = [[BdbHomeCellGoodsView alloc]init];
        [self addSubview:_goodsView];
        
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.mas_offset(30);
        }];
        [_sortImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.leading.equalTo(self).offset(10);
            make.trailing.equalTo(self).offset(-10);
            make.height.equalTo(@((self.height/2)-70));
        }];
        [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_sortImage.mas_bottom);
            make.leading.trailing.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}


- (void)setCellInfo:(ActRow *)cellInfo{
    NSLog(@"actRow.activity.img = %@  --= %@",cellInfo.activity.img,cellInfo.category_detail.name);
    self.titleView.actRow = cellInfo;
    self.goodsView.actRow = cellInfo;
    [self.sortImage setImage:[UIImage imageNamed:cellInfo.activity.img]];
//    [self.sortImage sd_setImageWithURL:[NSURL URLWithString:] placeholderImage:[UIImage imageNamed:cellInfo.category_detail.name]];
}
- (void)setCellback:(ClikedCellback)cellback{
    _cellback = cellback;
    self.goodsView.cellback = cellback;
}
@end
