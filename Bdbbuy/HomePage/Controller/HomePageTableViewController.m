//
//  HomePageTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "HomeGoodsCell.h"
#import "HomeSearchView.h"
#import "UIView+Layout.h"


@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSeachView];
}

- (void)configSeachView
{
    HomeSearchView *searchView = [[HomeSearchView alloc] initWithSeachEngineMargin:70 WithBackgroundImageName:@"search_bg.png" WithplaceHolderName:@"请输入搜索关键字" WithSearchButtonText:@"搜索"];
    
    searchView.frame = CGRectMake(0, self.tableView.top, self.view.width, 44);
//    searchView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:searchView];
    [self configHeaderView:searchView];
    
}


@end
