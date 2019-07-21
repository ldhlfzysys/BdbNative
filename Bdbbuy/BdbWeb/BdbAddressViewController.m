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
#import "UIView+Extension.h"

@interface BdbAddressViewController ()<BdbTableFootViewDelegate>
{
    UITextField *_name;
    UITextField *_phone;
    UITextView *_street;
}
@end

@implementation BdbAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"填写配送信息";
    BdbLightningView *lightning = [[BdbLightningView alloc]initWithFrame:CGRectMake(0, 0, Width, 30)];
    //    [self.headView addSubview:address];
    [self.view addSubview:lightning];
    
    UIImageView *line0 = [self line];
    line0.y = 29;
    [self.view addSubview:line0];
    
    UILabel *name = [self lable:@"收货人"];
    name.y = 30;
    [self.view addSubview:name];
    
    _name = [self filed:@""];
    _name.y = 30;
    [self.view addSubview:_name];
    
    UIImageView *line1 = [self line];
    line1.y = 70;
    [self.view addSubview:line1];
    
    UILabel *phone = [self lable:@"收货人"];
    phone.y = 70;
    [self.view addSubview:phone];
    
    _phone = [self filed:@""];
    _phone.y = 70;
    [self.view addSubview:_phone];
    
    UIImageView *line2 = [self line];
    line2.y = 110;
    [self.view addSubview:line2];
    
    
    _street = [self filed:@"请填写街道地址"];
    _street.x = 10;
    _street.y = 110;
    _street.height = 120;
    [self.view addSubview:_street];
    UIImageView *line3 = [self line];
    line3.y = 230;
    [self.view addSubview:line3];
    
    
    BdbTableFootView *footView = [[BdbTableFootView alloc]initWithFrame:CGRectMake(0, 231, Width, 50)];
    [footView.commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    footView.delegate = self;
    [self.view addSubview:footView];
}

- (void)didTableFootViewCommit {
    if (_name.text.length <=0 || _phone.text.length <= 0 || _street.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"地址和电话不能为空"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"感谢您的购买，我们会尽快安排发货"];
        [[BdbUserShopCarTool sharedInstance] removeAll];
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController.tabBarController setSelectedIndex:0];
        [[BdbNetwork sharedNetwork] loadHomeData:^(BOOL success, NSURLSessionDataTask * _Nonnull task, id  _Nonnull result, NSError * _Nonnull error) {
            
        }];
    }
   
}

- (UILabel *)lable:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, Width * 0.2, 40)];
    label.text = text;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}

- (UITextField *)filed:(NSString *)placehodle
{
    UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(Width * 0.2 + 10,0,Width*0.8 - 10,40)];
    text.placeholder = placehodle;
    text.font = [UIFont systemFontOfSize:14];
    return text;
}

- (UIImageView *)line
{
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.3;
    return line;
}

@end
