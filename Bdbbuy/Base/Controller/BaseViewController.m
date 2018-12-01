//
//  BaseViewController.m
//  Bdbbuy
//
//  Created by weixi1 on 2018/11/28.
//  Copyright © 2018年 bdbbuy. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadView
{
    if (![self baseViewClass]) {
        [super loadView];
    } else {
        self.view = [[[self baseViewClass] alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    }
}


- (Class)baseViewClass {
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
