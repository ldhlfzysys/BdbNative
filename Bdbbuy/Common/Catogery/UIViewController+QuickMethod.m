//
//  UIViewController+QuickMethod.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "UIViewController+QuickMethod.h"

@implementation UIViewController (QuickMethod)
- (float)qStatusbarHeight
{
    //状态栏高度
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)qNavigationbarHeight
{
    //导航栏高度+状态栏高度
    return self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (float)qTabbarHeight
{
    //Tabbar高度
    return self.tabBarController.tabBar.bounds.size.height;
}
@end
