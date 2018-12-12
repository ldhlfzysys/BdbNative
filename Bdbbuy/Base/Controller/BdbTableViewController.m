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
    
    self.tableView.height -= self.qTabbarHeight;
    
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
    
    CGFloat originTop = self.tableView.top;
    self.tableView.top = CGRectGetMaxY(headerView.frame);
    self.tableView.height -= self.tableView.top - originTop;
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


#pragma mark - 上下拉刷新方法----
- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
            __weak typeof(self) weakSelf = self;
            MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                [weakSelf.tableView.mj_header beginRefreshing];
                [weakSelf loadPreMoreData];
            }];
            
            NSMutableArray *pullingImages = [NSMutableArray array];
            for (int i = 1; i <= 24; i++) {
                NSString *imageName = [NSString stringWithFormat:@"dropdown_anim__000%d", i];
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    [pullingImages addObject:image];
                }
            }
            [gifHeader setImages:pullingImages forState:MJRefreshStatePulling];
            
            NSMutableArray *loadingImages = [NSMutableArray array];
            for (int i = 1; i <= 3; i++) {
                NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_0%d", i];
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    [loadingImages addObject:image];
                }
                
            }
            [gifHeader setImages:loadingImages forState:MJRefreshStateRefreshing];
            
            gifHeader.lastUpdatedTimeLabel.hidden = YES;
            gifHeader.stateLabel.hidden = YES;
            
            self.tableView.mj_header = gifHeader;
        } else{
            self.tableView.mj_header.hidden = YES;
        }
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
            __weak typeof(self) weakSelf = self;
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                //开始刷新
                [weakSelf.tableView.mj_footer beginRefreshing];
                [weakSelf loadMoreData];
            }];
            self.tableView.mj_footer = footer;
        } else {
            //移除下拉刷新
            self.tableView.mj_footer.hidden = NO;
        }
    }
}

- (void)loadPreMoreData {
    _pageNo = 0;
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadMoreData {
    _pageNo += 1;
    [self.tableView.mj_footer beginRefreshing];
}


- (void)requestMoreData {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


@end
