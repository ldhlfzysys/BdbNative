
#import "BdbTableFootView.h"

@interface BdbTableFootView ()
@property (nonatomic, strong) UILabel *money;
@end
@implementation BdbTableFootView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _money = [[UILabel alloc]init];
        _money.font = [UIFont systemFontOfSize:15];
        _money.textColor = [UIColor redColor];
        [self addSubview:_money];
        
        _commitBtn = [[UIButton alloc]init];
        [_commitBtn setTitle:@"选好了" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.backgroundColor = GeneralColor;
        [self addSubview:_commitBtn];
        
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.equalTo(@100);
            make.leading.equalTo(self).offset(15);
            make.height.equalTo(@15);
        }];
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.trailing.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(@100);
        }];
    }
    return self;
}
- (void)setSumMoney:(CGFloat)sumMoney{
    _sumMoney = sumMoney;
    self.money.text = [NSString stringWithFormat:@"共 CA$ %.2lf",sumMoney];
}
- (void)commitBtnClick{
    if ([self.delegate respondsToSelector:@selector(didTableFootViewCommit)] ) {
        [self.delegate didTableFootViewCommit];
    }
}
@end
