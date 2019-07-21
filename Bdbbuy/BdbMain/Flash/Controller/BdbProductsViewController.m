
#import "BdbProductsViewController.h"
#import "BdbGoodsCell.h"
#import "BdbGoods.h"

@interface BdbProductsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIImageView *tableFooterView;
@end

@implementation BdbProductsViewController

- (UIImageView *)tableFooterView{
    if (!_tableFooterView) {
        _tableFooterView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_common_footer"]];
        _tableFooterView.frame = CGRectMake(0, 0, Width*0.75, 70);
        _tableFooterView.contentMode = UIViewContentModeCenter;
    }
    return _tableFooterView;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view = [[UIView alloc]initWithFrame:CGRectMake(Width * 0.25, 0, Width * 0.75, Height)];
    
    [self bulidTableView];
}
- (void)bulidTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0);
    _tableView.tableFooterView = _tableFooterView;
    [self.view addSubview:_tableView];
   
    
    BdbAnimationRefreshHeader *header = [BdbAnimationRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefeshData)];
    _tableView.mj_header = header;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)headerRefeshData{
    [[BdbNetwork sharedNetwork] loadCategoryData:^(BOOL success, NSURLSessionDataTask * _Nonnull task, id  _Nonnull result, NSError * _Nonnull error) {
        [_tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.supermarketSouce.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.supermarketSouce.categories[section].products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BdbGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BdbGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.goods = self.supermarketSouce.categories[indexPath.section].products[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

#pragma mark - --- FlashViewControllerDelegate ---
- (void)didTableView:(UITableView *)tableView clickIndexPath:(NSIndexPath *)indexPath{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
