//
//  HomeProductController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/5.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeProductController.h"
#import "HomeProductCollectionViewCell.h"


static NSString * hpReuseIdentifier = @"HomeProductCollectionViewCell";

@interface HomeProductController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionViewFlowLayout * _flowlayout;
}
@property (nonatomic, strong) UIButton *bannerBtn;
@property (nonatomic, strong) BdbCollectionView *productCollectionView;
@end

@implementation HomeProductController
-(void)dealloc
{
    
}

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configBannerButton];
    [self configCollectionView];
    
}

-(void)reloadData
{
    [self.productCollectionView reloadData];
}


- (void)configBannerButton
{
    if (!self.bannerBtn) {
        self.bannerBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        self.bannerBtn.frame = CGRectMake(0, 0, self.view.width, 50);
        [self.bannerBtn setBackgroundImage:[UIImage imageNamed:@"banner1"] forState:UIControlStateNormal];
        [self.view addSubview:self.bannerBtn];
    }
}

- (void)configCollectionView
{
    if (!self.productCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat margin = 5;
        flowLayout.minimumLineSpacing = margin;
        flowLayout.itemSize = CGSizeMake((self.view.width - 3 * margin) * 0.5, 200);
        _flowlayout = flowLayout;
        
        BdbCollectionView *mainView = [[BdbCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerBtn.frame) + 5, self.view.width, 800) collectionViewLayout:flowLayout];
        mainView.backgroundColor = [UIColor clearColor];
        mainView.pagingEnabled = NO;
        mainView.showsHorizontalScrollIndicator = NO;
        mainView.showsVerticalScrollIndicator = YES;
        [mainView registerClass:[HomeProductCollectionViewCell class] forCellWithReuseIdentifier:hpReuseIdentifier];
        
        mainView.dataSource = self;
        mainView.delegate = self;
        mainView.scrollsToTop = YES;
        mainView.scrollEnabled = NO;
        self.productCollectionView = mainView;
        [self.view addSubview:self.productCollectionView];
    }
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hpReuseIdentifier forIndexPath:indexPath];
    return cell;
}




#pragma mark - Setter and Getter

-(NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}


@end
