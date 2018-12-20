//
//  BdbWebViewController.m
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbWebViewController.h"

@interface BdbWebViewController ()
{
    BOOL firstLoad;
}
@end

@implementation BdbWebViewController

- (instancetype)initWithAddress:(NSString *)urlString
{
    self = [super initWithAddress:urlString];
    self.showsToolBar = NO;
    self.timeoutInternal = 10;
    self.enabledWebViewUIDelegate = YES;
    self.navigationType = AXWebViewControllerNavigationToolItem;
    self.enabledWebViewUIDelegate = YES;
    firstLoad = YES;
    return self;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //paypal 和 alipay 打开外部应用
    if ([navigationAction.request.URL.absoluteString containsString:@"paypal"] || [navigationAction.request.URL.absoluteString containsString:@"alipay"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([navigationAction.request.URL.absoluteString containsString:@"payloading"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([navigationAction.request.URL.absoluteString containsString:@"com/index"]) {
        firstLoad = NO;
        if (self.tabBarController.selectedIndex != 0) {
            [self.tabBarController setSelectedIndex:0];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if (self.tabBarController.selectedIndex == 0){
            decisionHandler(WKNavigationActionPolicyAllow);
            return;
        }
        
    }
    if ([navigationAction.request.URL.absoluteString containsString:@"com/category"]) {
        firstLoad = NO;
        if (self.tabBarController.selectedIndex != 1) {
            [self.tabBarController setSelectedIndex:1];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if (self.tabBarController.selectedIndex == 1){
            decisionHandler(WKNavigationActionPolicyAllow);
            return;
        }
    }
    if ([navigationAction.request.URL.absoluteString containsString:@"com/user"]) {
        firstLoad = NO;
        if (self.tabBarController.selectedIndex != 3) {
            [self.tabBarController setSelectedIndex:3];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if (self.tabBarController.selectedIndex == 3){
            decisionHandler(WKNavigationActionPolicyAllow);
            return;
        }
        
    }
    
    if ([navigationAction.request.URL.absoluteString containsString:@"com/cart"]) {
        firstLoad = NO;
        if (self.tabBarController.selectedIndex != 2) {
            [self.tabBarController setSelectedIndex:2];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if (self.tabBarController.selectedIndex == 2){
            decisionHandler(WKNavigationActionPolicyAllow);
            return;
        }
        
        
    }
    
    if ([navigationAction.request.URL.absoluteString containsString:@"bdbbuy.com"] && !firstLoad) {
        
        BdbWebViewController *bdb = [[BdbWebViewController alloc] initWithAddress:navigationAction.request.URL.absoluteString];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bdb animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    firstLoad = NO;
    // Disable all the '_blank' target in page's target.
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    }
  
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:navigationAction.request.URL.absoluteString];

    
    
    if ([navigationAction.request.URL.absoluteString containsString:@"ax_404_not_found"] || [navigationAction.request.URL.absoluteString containsString:@"ax_network_error"]) {
        
        [self loadURL:_URL];
    }
 
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end

@implementation BdbTabWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.webView reload];
    self.tabBarController.tabBar.hidden = NO;
}


@end
