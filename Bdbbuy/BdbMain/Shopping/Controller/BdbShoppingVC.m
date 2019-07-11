
#import "BdbShoppingVC.h"
#import "BdbDefaultView.h"
#import "BdbShoppingCell.h"
#import "BdbUserShopCarTool.h"
#import "BdbTableFootView.h"
#import "BdbAddressView.h"
#import "BdbLightningView.h"
#import "BdbAddressViewController.h"
@interface BdbShoppingVC ()<UITableViewDelegate,UITableViewDataSource,BdbTableFootViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BdbDefaultView *defaultView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) BdbTableFootView *footView;

@end
@implementation BdbShoppingVC
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"购物车";
    [self bulidNotifacation];
    [self bulidTableView];
    [self bulidDefaultView];
}
- (void)bulidNotifacation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IncreaseShoppingCart) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemoveGoods) name:LFBShopCarDidRemoveProductNSNotification object:nil];
    
}
- (void)IncreaseShoppingCart{
    self.footView.sumMoney = [[BdbUserShopCarTool sharedInstance]getShopCarGoodsPrice];
}
- (void)didRemoveGoods{
    self.footView.sumMoney = [[BdbUserShopCarTool sharedInstance]getShopCarGoodsPrice];
}
- (void)bulidTableView{
    self.tableView = ({
        UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.rowHeight = 80;
        //tableview.hidden = YES;
        tableview.backgroundColor = [UIColor clearColor];
        tableview;
    });
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self bulidTableHeadView];
    [self bulidTableFootView];
}
- (void)bulidTableHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 30)];
    BdbLightningView *lightning = [[BdbLightningView alloc]initWithFrame:CGRectMake(0, 0, Width, 30)];
    [self.headView addSubview:lightning];
    self.tableView.tableHeaderView = self.headView;
}
- (void)bulidTableFootView{
    _footView = [[BdbTableFootView alloc]initWithFrame:CGRectMake(0, 0, Width, 50)];
    _footView.delegate = self;
    self.tableView.tableFooterView = _footView;
}
- (void)bulidDefaultView{
    _defaultView = [[BdbDefaultView alloc]init];
    _defaultView.hidden = YES;
    [self.view addSubview:_defaultView];
    [_defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(170);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[BdbUserShopCarTool sharedInstance]isEmpty]) {
        self.defaultView.hidden = NO;
        self.tableView.hidden = YES;
    }else{
        self.defaultView.hidden = YES;
        self.tableView.hidden = NO;
        __weak typeof (self) weakSelf = self;
        [SVProgressHUD showWithStatus:@"加载中"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.dataList = [BdbUserShopCarTool sharedInstance].shopCar;
            weakSelf.footView.sumMoney = [[BdbUserShopCarTool sharedInstance]getShopCarGoodsPrice];
            [weakSelf.tableView reloadData];
            [SVProgressHUD dismiss];
        });
    }
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ID";
    BdbShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BdbShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.goods = self.dataList[indexPath.row];
    return cell;
}

- (void)didTableFootViewCommit{
    UIViewController *moneyVc = [[BdbAddressViewController alloc]init];
    [self.navigationController pushViewController:moneyVc animated:YES];
}

@end
