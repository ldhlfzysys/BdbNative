//
//  AppDelegate.m
//  Bdbbuy
//
//  Created by weixi1 on 2018/11/27.
//  Copyright © 2018年 bdbbuy. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageTableViewController.h"
#import "BdbTabBarViewController.h"
#import "BdbWebViewController.h"
#import "UIView+Layout.h"
#import "AXWebViewController.h"
#import "BdbNetwork.h"

@interface AppDelegate ()<UITabBarControllerDelegate>
{
    BdbTabWebViewController *category;
    BdbTabWebViewController *cart;
    BdbTabWebViewController *user;
    BdbWebViewControllerWeb *webVC;
    NSArray *tabViewControllers;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    UIWindow *window  = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *launch = [[UIViewController alloc] init];
    launch.view.backgroundColor = [UIColor whiteColor];
    [[BdbNetwork sharedNetwork] sendGetRequestWithPath:@"api/index/shownative" WithParam:nil compeletion:^(BOOL success, NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultDic, NSError * _Nonnull error) {
//        NSLog(@"%@",resultDic);
        if ([[resultDic objectForKey:@"shownative"] integerValue] == 0) {
            [self loadWeb:window];
        }else{
            [self loadnative:window];
        }
    }];
    window.rootViewController = launch;
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadnative:(UIWindow*)window
{
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString*userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];NSString*newUserAgent = [userAgent stringByAppendingString:@" bdbmobile"];//自定义需要拼接的字符串
    NSDictionary*dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent,@"UserAgent",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
    BdbTabBarViewController *tabbar = [[BdbTabBarViewController alloc] init];
    
    //首页
    HomePageTableViewController *homeVC = [[HomePageTableViewController alloc] init];
    homeVC.title = @"首页";
    homeVC.tabBarItem = [self tabBarName:@"首页" image:@"home" selected:@"home_highlight"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
    //购物车
    cart = [[BdbTabWebViewController alloc] initWithAddress:@"https://m.bdbbuy.com/cart"];
    cart.title = @"购物车";
    cart.tabBarItem = [self tabBarName:@"购物车" image:@"cart" selected:@"cart_highlight"];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:cart];
    
    //分类
    category = [[BdbTabWebViewController alloc] initWithAddress:@"https://m.bdbbuy.com/category"];
    category.title = @"分类";
    category.tabBarItem = [self tabBarName:@"分类" image:@"category" selected:@"category_highlight"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:category];
    
    //我
    user = [[BdbTabWebViewController alloc] initWithAddress:@"https://m.bdbbuy.com/user"];
    user.title = @"我";
    user.tabBarItem = [self tabBarName:@"我" image:@"user" selected:@"user_highlight"];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:user];
    tabViewControllers = @[homeVC,category,cart,user];
    tabbar.viewControllers = @[nav1,nav2,nav3,nav4];
    tabbar.delegate = self;
    window.rootViewController = tabbar;
}

- (void)loadWeb:(UIWindow*)window
{
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString*userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];NSString*newUserAgent = [userAgent stringByAppendingString:@""];//自定义需要拼接的字符串
    NSDictionary*dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent,@"UserAgent",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    webVC = [[BdbWebViewControllerWeb alloc] initWithAddress:@"https://m.bdbbuy.com"];
    webVC.showsToolBar = NO;
    webVC.timeoutInternal = 10;
    webVC.enabledWebViewUIDelegate = YES;
    webVC.navigationType = AXWebViewControllerNavigationToolItem;
    webVC.enabledWebViewUIDelegate = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
    window.rootViewController = nav;
}

- (UITabBarItem *)tabBarName:(NSString *)title image:(NSString *)image selected:(NSString *)selected
{
    UIImage *icon = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [[UIImage imageNamed:selected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:icon selectedImage:selectImage];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:218 / 255.0 green:71 / 255.0 blue:68 / 255.0 alpha:1]} forState:UIControlStateSelected];
    [tabbarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:133 / 255.0 green:133 / 255.0 blue:133 / 255.0 alpha:1]} forState:UIControlStateNormal];
    return tabbarItem;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    switch (tabBarController.selectedIndex) {
        case 0:
        {

            break;
        }
        case 1:
        {
            AXWebViewController *vc = tabViewControllers[1];
//            if ([vc.webView.URL.absoluteString containsString:@"cart"] || [vc.URL.absoluteString containsString:@"user"]) {
                [vc loadURL:[NSURL URLWithString:@"https://m.bdbbuy.com/category"]];
//            }
            
            break;
        }
        case 2:
        {
            AXWebViewController *vc = tabViewControllers[2];
//            if ([vc.webView.URL.absoluteString containsString:@"category"] || [vc.URL.absoluteString containsString:@"user"]) {
            
                [vc loadURL:[NSURL URLWithString:@"https://m.bdbbuy.com/cart"]];
//            }
            break;
        }
        case 3:
        {
            AXWebViewController *vc = tabViewControllers[3];
//            if ([vc.webView.URL.absoluteString containsString:@"cart"] || [vc.URL.absoluteString containsString:@"category"]) {
            
                [vc loadURL:[NSURL URLWithString:@"https://m.bdbbuy.com/user"]];
//            }
            break;
        }
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
