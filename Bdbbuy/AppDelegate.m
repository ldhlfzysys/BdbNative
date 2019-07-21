//
//  AppDelegate.m
//  Bdbbuy
//
//  Created by weixi1 on 2018/11/27.
//  Copyright © 2018年 bdbbuy. All rights reserved.
//

#import "AppDelegate.h"
#import "BdbWKWebViewController.h"
#import "BdbNetwork.h"
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import "BdbMainTabBarController.h"
#import "BdbLaunchViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate,UNUserNotificationCenterDelegate>
{
    BdbWKWebViewController *webVC;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:@"5bd5a5d5b465f5a00c00006d" channel:@"App Store"];
    
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    // Override point for customization after application launch.
    UIWindow *window  = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    BdbLaunchViewController *launch = [[BdbLaunchViewController alloc] init];
    
    [[BdbNetwork sharedNetwork] sendGetRequestWithPath:@"api/index/shownative" WithParam:nil compeletion:^(BOOL success, NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultDic, NSError * _Nonnull error) {
        NSString *currentBundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if ([[resultDic objectForKey:currentBundleVersion] integerValue] == 1) {
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
    [self buildKeyWindow];
}


- (void)buildKeyWindow{
    NSString *isFirestOpenApp = [[NSUserDefaults standardUserDefaults]objectForKey:IsFirstOpenApp];
    if (isFirestOpenApp == nil) {
        [self showMainTabBarController];
        [[NSUserDefaults standardUserDefaults]setObject:IsFirstOpenApp forKey:IsFirstOpenApp];
    }else
    {
        [self showMainTabBarController];
    }
    [self.window makeKeyAndVisible];
}

- (void)showMainTabBarController
{
    self.window.rootViewController = [[BdbMainTabBarController alloc]init];
}

- (void)loadWeb:(UIWindow*)window
{
    UIWebView*webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString*userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];NSString*newUserAgent = [userAgent stringByAppendingString:@""];//自定义需要拼接的字符串
    NSDictionary*dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent,@"UserAgent",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    webVC = [[BdbWKWebViewController alloc] init];
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

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于后台时的本地推送接受
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
