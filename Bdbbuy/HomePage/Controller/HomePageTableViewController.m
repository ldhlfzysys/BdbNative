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
@property (nonatomic,strong) NSMutableArray *homeCards;

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    配置搜索条
    [self configSeachView];
    __weak typeof(self) weakSelf = self;
#warning 网速太差，本地debug时暂停网络请求
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
    
    
}

- (void)configSeachView
{
    HomeSearchView *searchView = [[HomeSearchView alloc] initWithSeachEngineMargin:70 WithBackgroundImageName:@"search_bg.png" WithplaceHolderName:@"请输入搜索关键字" WithSearchButtonText:@"搜索"];
    searchView.frame = CGRectMake(0, self.tableView.top, self.view.width, 44);
    [self.view addSubview:searchView];
    [self configHeaderView:searchView];
    searchView.delegate = self;
    
}

- (void)configTableView
{
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
    NSDictionary *catagoryDic = [HomeDataProvider sharedProvider].catogeryInfos[index];
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
