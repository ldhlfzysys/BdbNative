//
//  HomePageTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "HomeSearchView.h"
#import "MultiButtonsView.h"
#import "HomeDataProvider.h"


static NSString *searchBaseURL = @"https://m.bdbbuy.com/search";

@interface HomePageTableViewController ()<MultiButtonsViewDelegate, HomeSearchViewDelegate>
@property (nonatomic, strong) NSMutableArray *homeCards;
@property (nonatomic, strong) HomeSearchView *searchView;

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    配置搜索条
    [self configSeachView];
    __weak typeof(self) weakSelf = self;
    [[HomeDataProvider sharedProvider] loadCacheDataWithCompletionBlock:^(BOOL compelet) {
        if (compelet) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf configTableView];
            strongSelf.cards = [strongSelf.homeCards copy];
        }
    }];
    
    [[HomeDataProvider sharedProvider] requestHomeDataWithCompletionBlock:^(BOOL compelet) {
        if (compelet) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf configTableView];
            strongSelf.cards = [strongSelf.homeCards copy];

        }
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.searchView) {
        [self.searchView clearSearchView];
    }
    
}

- (void)configSeachView
{
    HomeSearchView *searchView = [[HomeSearchView alloc] initWithSeachEngineMargin:70 WithBackgroundImageName:@"search_bg.png" WithplaceHolderName:@"请输入搜索关键字" WithSearchButtonText:@"搜索"];
    searchView.frame = CGRectMake(0, self.tableView.top, self.view.width, 44);
    [self.view addSubview:searchView];
    [self configHeaderView:searchView];
    self.searchView = searchView;
    searchView.delegate = self;
    
}

- (void)configTableView
{
    [self.homeCards removeAllObjects];
    for (NSDictionary *dic in [HomeDataProvider sharedProvider].homeData) {
        NSInteger type = [[dic objectForKey:@"type"] integerValue];
        BdbCard *card = [[NSClassFromString([BdbCard getCardTypeWithType:type]) alloc] init];
        card.dataDic = dic;
        [self.homeCards addObject:card];
    }
}

- (void)configLineView
{
    BdbCard *lineCard = [[BdbCard alloc] init];
    lineCard.cardClassID = @"BdbLineTableViewCell";
    
    lineCard.cardHeight = 10;
    [self.homeCards addObject:lineCard];
}

#pragma mark - Delegate
-(void)multibuttonsview:(MultiButtonsView *)buttonsView DidSelectButton:(NSInteger)index
{
    
    NSArray *catogeryInfos = nil;
    for (NSDictionary *dic in [HomeDataProvider sharedProvider].homeData) {
        int type = [dic[@"type"] intValue];
        if (type == 2) {
            catogeryInfos = dic[@"data"];
            break;
        }
    }
    
    NSDictionary *catagoryDic = catogeryInfos[index];
    BdbWebViewController *category = [[BdbWebViewController alloc] initWithAddress:catagoryDic[@"url"]];
    category.title = catagoryDic[@"name"];
    [self resignFirstResponder];
    [self.navigationController pushViewController:category animated:NO];
    
}

-(void)homesearchview:(HomeSearchView *)searchView didClickSearchButton:(UIButton *)searchButton WithSearchText:(nonnull NSString *)searchText
{
    NSString *url = [NSString stringWithFormat:@"%@?search_key=%@", searchBaseURL, searchText];
    BdbWebViewController *searchVC = [[BdbWebViewController alloc] initWithAddress:url];
    searchVC.title = @"搜索结果";
    [searchView resignFirstResponder];
    [self.navigationController pushViewController:searchVC animated:NO];
}



#pragma mark - Setter & Getter
-(NSMutableArray *)homeCards
{
    if (!_homeCards) {
        _homeCards = [NSMutableArray array];
    }
    return _homeCards;
}

@end
