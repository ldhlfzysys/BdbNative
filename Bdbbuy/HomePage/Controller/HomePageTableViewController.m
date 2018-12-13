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
#import "HomeProductView.h"


static NSString *searchBaseURL = @"https://m.bdbbuy.com/search";

@interface HomePageTableViewController ()<MultiButtonsViewDelegate, HomeSearchViewDelegate,HomeProductViewDelegate>
@property (nonatomic, strong) NSMutableArray *homeCards;
@property (nonatomic, strong) HomeSearchView *searchView;

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = NO;
    
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.searchView) {
        [self.searchView clearSearchView];
    }
    __weak typeof(self) weakSelf = self;
    [[HomeDataProvider sharedProvider] requestHomeDataWithCompletionBlock:^(BOOL compelet) {
        if (compelet) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf configTableView];
            strongSelf.cards = [strongSelf.homeCards copy];
            [strongSelf.tableView.mj_header endRefreshing];
        }
    }];
    
}

-(void)loadPreMoreData
{
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
    [self jumpToNextPageWithTitle:catagoryDic[@"name"] WithURL:catagoryDic[@"url"]];
}

-(void)homesearchview:(HomeSearchView *)searchView didClickSearchButton:(UIButton *)searchButton WithSearchText:(nonnull NSString *)searchText
{
    NSString *url = [NSString stringWithFormat:@"%@?search_key=%@", searchBaseURL, searchText];
    [self jumpToNextPageWithTitle:@"搜索结果" WithURL:url];
}

-(void)homeproductview:(HomeProductView *)hpView didSelectHeaderButton:(UIButton *)btn WithHeaderURL:(NSString *)url
{
    if (url && url.length > 0 && [url hasPrefix:@"http"]) {
        [self jumpToNextPageWithTitle:@"分类" WithURL:url];
    }
    
}

-(void)homeproductview:(HomeProductView *)hpView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath WithProductURL:(NSString *)url
{
    if (url && url.length > 0 && [url hasPrefix:@"http"]) {
        [self jumpToNextPageWithTitle:@"详情" WithURL:url];
    }
}


- (void)hideTabbarAndPushViewController:(UIViewController *)vc animated:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:animated];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)jumpToNextPageWithTitle:(NSString *)title WithURL:(NSString *)url
{
//    BdbBaseURL
    NSString *catogeryAddress = [NSString stringWithFormat:@"%@category?category_id=", BdbBaseURL];
    if ([url containsString:catogeryAddress]) {
        // 跳转分类的网址拦截，跳转tabbar
        NSInteger catogeryIndex = [(BdbTabBarViewController *)self.tabBarController getTabbarItemIndexWithTabbarTitle:@"分类"];
        UINavigationController *catogeryNav = self.tabBarController.viewControllers[catogeryIndex];
        [catogeryNav popViewControllerAnimated:NO];
        BdbWebViewController *catogeryVC = (BdbWebViewController *)catogeryNav.topViewController;
        [self.tabBarController setSelectedIndex:catogeryIndex];
        [catogeryVC loadURL:[NSURL URLWithString:url]];
    } else {
        BdbWebViewController *product = [[BdbWebViewController alloc] initWithAddress:url];
        product.title = title;
        [self resignFirstResponder];
        [self hideTabbarAndPushViewController:product animated:YES];
    }
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
