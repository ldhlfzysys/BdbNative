
#import "BdbBaseNavigationController.h"
#import "BdbMainTabBarController.h"
#import "BdbHomeViewController.h"
#import "BdbFlashViewController.h"
#import "BdbMyViewController.h"
#import "BdbUserShopCarTool.h"
#import "BdbShoppingVC.h"

@implementation BdbMainTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addMainTabBarController];
    [self addNotification];
}



- (void)addMainTabBarController
{
    [self setupChildViewController:@"首页" viewController:[BdbHomeViewController new] image:@"v2_home" selectedImage:@"v2_home_r"];
    [self setupChildViewController:@"挑选商品" viewController:[BdbFlashViewController new] image:@"v2_order" selectedImage:@"v2_order_r"];
    [self setupChildViewController:@"购物车" viewController:[BdbShoppingVC new] image:@"shopCart" selectedImage:@"shopCart_r"];
//    [self setupChildViewController:@"我的" viewController:[AJMyViewController new] image:@"v2_my" selectedImage:@"v2_my_r"];
    
}
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(IncreaseShoppingCart) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
}
- (void)IncreaseShoppingCart{
    UIViewController *shoppingVC = self.childViewControllers[2];
    NSInteger shoppingIndex = [[BdbUserShopCarTool sharedInstance]getShopCarGoodsNumber];
    if (shoppingIndex == 0) {
        shoppingVC.tabBarItem.badgeValue = nil;
        return;
    }
    shoppingVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",shoppingIndex];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupChildViewController:(NSString *)title viewController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [UIImage imageNamed:image];
    item.selectedImage = [UIImage imageNamed:selectedImage];
    item.title = title;
    controller.tabBarItem = item;
    controller.title = title;
    BdbBaseNavigationController *naController = [[BdbBaseNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:naController];
}

@end
