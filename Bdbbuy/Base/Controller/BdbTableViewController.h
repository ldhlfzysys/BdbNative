//
//  BdbTableViewController.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BaseViewController.h"
#import "BdbTableView.h"
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface BdbTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    BdbTableView *_tableView;
}

@property (nonatomic, strong) BdbTableView *tableView;
//是否显示山下拉刷新(可以控制是否显示)
@property (nonatomic) BOOL showRefreshHeader;
@property (nonatomic) BOOL showRefreshFooter;
@property (nonatomic, assign) NSInteger pageNo;

- (Class)tableViewClass;
- (void)configTableViewInsets:(UIEdgeInsets)edgeInsets;
- (void)configHeaderView:(UIView *)headerView;

- (void)loadPreMoreData;
- (void)loadMoreData;
- (void)requestMoreData;

@end

NS_ASSUME_NONNULL_END
