//
//  BdbTableViewController.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BaseViewController.h"
#import "BdbTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BdbTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    BdbTableView *_tableView;
}

@property (nonatomic, strong) BdbTableView *tableView;
- (Class)tableViewClass;
- (void)configTableViewInsets:(UIEdgeInsets)edgeInsets;
- (void)configHeaderView:(UIView *)headerView;
@end

NS_ASSUME_NONNULL_END
