//
//  HomeProductView.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeProductView.h"
#import "UIButton+WebCache.h"
#import "HomeProductCollectionViewCell.h"


static CGFloat topMargin = 10;
static CGFloat leftMargin = 10;

static NSString * hpReuseIdentifier = @"HomeProductCollectionViewCell";
@interface HomeProductView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation HomeProductView
{
    UIButton *_headerButton;
    BdbCollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowlayout;
}


#pragma mark - Public
- (CGFloat)getViewHeight
{
    CGFloat viewHeight = self.height;
    
    return viewHeight;
}

- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowlayout
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _flowlayout = flowlayout;
        [self createSubviews];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self configSubviews];
}



- (void)createSubviews
{
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerButton = headerBtn;
    [self addSubview:_headerButton];
    [_headerButton addTarget:self action:@selector(headerButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    BdbCollectionView *collectionView = [[BdbCollectionView alloc] initWithFrame:CGRectMake(leftMargin, topMargin, self.width - 2 * leftMargin, 200) collectionViewLayout:_flowlayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    _collectionView = collectionView;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[HomeProductCollectionViewCell class] forCellWithReuseIdentifier:hpReuseIdentifier];
    
    
}


- (void)configSubviews
{
    // 顶部的图片展示，可跳转分类页面
    _headerButton.top = topMargin;
    _headerButton.left = leftMargin;
    _headerButton.width = self.width - 2 * leftMargin;
    if (self.headerBtnHeight && self.headerBtnHeight > 0) {
        _headerButton.height = _headerBtnHeight;
    } else {
        [_headerButton sizeToFit];
    }
    
    _collectionView.width = _headerButton.width;
    _collectionView.left = _headerButton.left;
    _collectionView.top = _headerButton.bottom + topMargin;
    
    if (self.collectionViewHeight && self.collectionViewHeight > 0) {
        _collectionView.height = self.collectionViewHeight;
    } else {
        if (_flowlayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            // 垂直滚动
            if (_products && _products.count > 0) {
                _collectionView.height = _collectionView.collectionViewLayout.collectionViewContentSize.height + topMargin;
            } else
            {
                _collectionView.height = _flowlayout.itemSize.height +  topMargin;
            }
            
        } else {
            // 水平滚动
            _collectionView.height = _flowlayout.itemSize.height + topMargin;
        }
    }
    self.height = CGRectGetMaxY(_collectionView.frame);
    
}



#pragma mark - action
- (void)headerButtonDidClick:(UIButton *)button
{
    
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hpReuseIdentifier forIndexPath:indexPath];
    
    BdbCard *card = [self.products objectAtIndex:indexPath.row];
    card.delegate = self;
    if (![card conformsToProtocol:@protocol(BdbCardProtocol)]) {
        return nil;
    }
    id<BdbCardProtocol> cellCard = card;
    NSMutableDictionary *datadic = [NSMutableDictionary dictionaryWithDictionary:card.dataDic];
    [datadic setObject:@(_flowlayout.itemSize.width) forKey:@"cellWidth"];
    [datadic setObject:@(_flowlayout.itemSize.height) forKey:@"cellHeight"];
    if (cell.contentView.subviews.count <= 0) {
        // 复用
        UIView *cardView = [cellCard viewWithCardData:datadic];
        [cell.contentView addSubview:cardView];
    } else {
        [cellCard refreshView:cell.contentView.subviews[0] WithData:datadic];
    }
    
    return cell;
}


#pragma mark - setter and getter
- (void)setHeaderButtonImageName:(NSString *)headerButtonImageName
{
    _headerButtonImageName = headerButtonImageName;
    if ([headerButtonImageName hasPrefix:@"http"]) {
        [_headerButton sd_setImageWithURL:[NSURL URLWithString:headerButtonImageName] forState:UIControlStateNormal];
    } else
    {
        [_headerButton setImage:[UIImage imageNamed:headerButtonImageName] forState:UIControlStateNormal];
    }
    if (self.headerBtnHeight && self.headerBtnHeight > 0) {
        _headerButton.height = _headerBtnHeight;
    } else {
        [_headerButton sizeToFit];
    }
}

- (void)setProducts:(NSArray *)products
{
    _products = products;
    [_collectionView reloadData];
    [self configSubviews];
}

- (void)setScrollEnable:(BOOL)scrollEnable
{
    _scrollEnable = scrollEnable;
    _collectionView.scrollEnabled = scrollEnable;
}

-(void)setCollectionViewHeight:(CGFloat)collectionViewHeight
{
    _collectionViewHeight = collectionViewHeight;
    _collectionView.height = collectionViewHeight;
}

-(void)setHeaderBtnHeight:(CGFloat)headerBtnHeight
{
    _headerBtnHeight = headerBtnHeight;
    _headerButton.height = headerBtnHeight;
}

@end
