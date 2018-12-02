//
//  BdbTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbTableViewController.h"
#import "CommonDefine.h"

@interface BdbTableViewController ()
{
    UITableViewStyle _tableViewStyle;
}
@end

@implementation BdbTableViewController
@synthesize tableView = _tableView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configTableViewInsets:UIEdgeInsetsMake(BdbDefaultTableViewBaseInsetTop, 0, 0, 0)];
}

-(void)loadView
{
    [super loadView];
    Class tableViewClass = [self tableViewClass];
    if (!tableViewClass) {
        tableViewClass = [BdbTableView class];
    }
    if (!_tableViewStyle) {
        _tableViewStyle = UITableViewStylePlain;
    }
    self.tableView = [[tableViewClass alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
#if __IPHONE_11_0 && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        //修复 滚动条来回跳动的问题 （ios11 时默认开启Self-Sizing）
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if(_tableViewStyle == UITableViewStylePlain)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    else
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    self.tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:self.tableView];
}


#pragma mark - Initial
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithTableViewStyle:(UITableViewStyle)style
{
    if ((self = [self initWithNibName:nil bundle:nil]))
    {
        _tableViewStyle = style;
        
    }
    
    return self;
}

#pragma mark - public
- (void)configTableViewInsets:(UIEdgeInsets)edgeInsets
{
    self.tableView.contentInset = edgeInsets;
}

- (void)configHeaderView:(UIView *)headerView
{
    if (headerView.top == 0) {
        headerView.top = self.tableView.contentInset.top;
    }
    
    self.tableView.top = headerView.top + headerView.height;
    [self configTableViewInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (Class)tableViewClass
{
    return [BdbTableView class];
}


#pragma mark - Setter and Getter
- (void)setTableView:(BdbTableView *)tableView
{
    if (_tableView != tableView)
    {
        _tableView = tableView;
    }
}

#pragma mark - UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
     }
}



@end
