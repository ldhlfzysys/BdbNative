//
//  BdbAddressViewController.m
//  Bdbbuy
//
//  Created by liudonghuan on 2019/7/7.
//  Copyright © 2019 bdbbuy. All rights reserved.
//

#import "BdbAddressViewController.h"
#import "BdbUserShopCarTool.h"
#import "BdbLightningView.h"
#import "BdbTableFootView.h"

@interface BdbAddressViewController ()<BdbTableFootViewDelegate>
{
    UITextField *text;
    UITextField *text2;
}
@end

@implementation BdbAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"填写配送信息";
    BdbLightningView *lightning = [[BdbLightningView alloc]initWithFrame:CGRectMake(0, 0, Width, 30)];
    //    [self.headView addSubview:address];
    [self.view addSubview:lightning];
    text = [[UITextField alloc] initWithFrame:CGRectMake(0, 30, Width, 80)];
    text.borderStyle = UITextBorderStyleLine;
    text.placeholder = @"填写收货地址";
    [self.view addSubview:text];
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 110, Width, 50)];
    text2.borderStyle = UITextBorderStyleLine;
    text2.placeholder = @"填写联系电话";
    [self.view addSubview:text2];
    
    BdbTableFootView *footView = [[BdbTableFootView alloc]initWithFrame:CGRectMake(0, 160, Width, 50)];
    [footView.commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    footView.delegate = self;
    [self.view addSubview:footView];
}

- (void)didTableFootViewCommit {
    if (text.text.length <=0 || text2.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"地址和电话不能为空"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"感谢您的购买，我们会尽快安排发货"];
        [[BdbUserShopCarTool sharedInstance] removeAll];
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController.tabBarController setSelectedIndex:0];
    }
   
}


@end
