//
//  HomePageTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "HomeGoodsCell.h"
#import "HomeBannerCellTableViewCell.h"
#import "HomeSearchView.h"
#import "MultiButtonsView.h"
#import "HomeDataProvider.h"



@interface HomePageTableViewController ()
@property (nonatomic,strong) NSMutableArray *homeCards;

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    配置搜索条
    [self configSeachView];
    __weak typeof(self) weakSelf = self;
    [[HomeDataProvider sharedProvider] requestHomeDataWithCompletionBlock:^(BOOL compelet) {
        if (compelet) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf configBannerView];
            [strongSelf configCatogeryView];
            strongSelf.cards = [strongSelf.homeCards copy];
            
        }
    }];
   
}

- (void)configSeachView
{
    HomeSearchView *searchView = [[HomeSearchView alloc] initWithSeachEngineMargin:70 WithBackgroundImageName:@"search_bg.png" WithplaceHolderName:@"请输入搜索关键字" WithSearchButtonText:@"搜索"];
    searchView.frame = CGRectMake(0, self.tableView.top, self.view.width, 44);
    [self.view addSubview:searchView];
    [self configHeaderView:searchView];
    
}

- (void)configBannerView
{
    BdbCard *bannerCard = [[BdbCard alloc] init];
    bannerCard.cardClassID = @"HomeBannerCellTableViewCell";
    NSMutableArray *bannerArr = [NSMutableArray array];
    NSArray *netBannerArr = [HomeDataProvider sharedProvider].bannerUrls;
    if (netBannerArr && netBannerArr.count > 0) {
        bannerArr = [netBannerArr mutableCopy];
    } else
    {
        for (int i = 1; i <= 4; i++) {
            [bannerArr addObject:[NSString stringWithFormat:@"banner%d", i]];
        }
    }
    
    bannerCard.dataDic = [NSDictionary dictionaryWithObject:bannerArr forKey:@"data"];
    [self.homeCards addObject:bannerCard];
}


- (void)configCatogeryView
{
    BdbCard *catogeryCard = [[BdbCard alloc] init];
    catogeryCard.cardClassID = @"HomeCatogeryTableViewCell";
    NSMutableArray *buttonInfoArr = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < 10; i++) {
        ButtonInfo *info = [[ButtonInfo alloc] init];
        info.title = @"测试代码";
        info.normalImageName = @"user";
        info.vertical = YES;
        [buttonInfoArr addObject:info];
    }
    [dict setObject:buttonInfoArr forKey:@"data"];
    [dict setObject:@(5) forKey:@"maxLineCount"];
    
    catogeryCard.dataDic = [dict copy];
    catogeryCard.cardHeight = 150;
    [self.homeCards addObject:catogeryCard];
    
}


-(NSMutableArray *)homeCards
{
    if (!_homeCards) {
        _homeCards = [NSMutableArray array];
    }
    return _homeCards;
}

@end
