//
//  BdbTabBarViewController.m
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbTabBarViewController.h"

@interface BdbTabBarViewController ()

@end

@implementation BdbTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)getTabbarItemIndexWithTabbarTitle:(NSString *)title
{
    NSArray *items = self.tabBar.items;
    NSInteger index = -1;
    for (NSInteger  i = 0; i < items.count; i++) {
        UITabBarItem *item = items[i];
        if ([item.title isEqualToString:title]) {
            index = i;
            break;
        }
    }
    return index;
}


@end
