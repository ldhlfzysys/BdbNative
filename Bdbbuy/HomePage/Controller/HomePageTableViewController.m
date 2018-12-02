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
#import "UIView+Layout.h"


@interface HomePageTableViewController ()
@property (nonatomic,strong) NSMutableArray *homeCards;

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSeachView];
    [self configBannerView];
    self.cards = [self.homeCards copy];
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
    
    [self.homeCards addObject:bannerCard];
}



-(NSMutableArray *)homeCards
{
    if (!_homeCards) {
        _homeCards = [NSMutableArray array];
    }
    return _homeCards;
}

@end
