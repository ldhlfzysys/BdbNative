//
//  BdbWebViewController.m
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbWebViewController.h"

@interface BdbWebViewController ()<WKNavigationDelegate,UIScrollViewDelegate,UITextViewDelegate,WKScriptMessageHandler>

@end

@implementation BdbWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *cc=[[WKUserContentController alloc] init];
    config.userContentController=cc;
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webview.navigationDelegate = self;
    self.webview.scrollView.delegate = self;
    [self.view addSubview:self.webview];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_baseUrl]]];
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
