//
//  BdbWebViewController.m
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbWKWebViewController.h"
#import "SVProgressHUD.h"

@interface BdbWKWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation BdbWKWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = YES;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        NSString *currentBundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        config.applicationNameForUserAgent = [NSString stringWithFormat:@"BDBBUY-%@",currentBundleVersion];
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://bdbbuy.com"]]];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (title.length <= 0) {
        title = @"八点半买";
    }
    [super setTitle:title];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
{
    [SVProgressHUD dismiss];
    self.title = _webView.title;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
{
    [SVProgressHUD dismiss];
    self.title = _webView.title;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
{
    [SVProgressHUD showWithStatus:@"loading"];
    self.title = _webView.title;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
{
    [SVProgressHUD showErrorWithStatus:@"network error"];
    [SVProgressHUD dismissWithDelay:1];
    self.title = _webView.title;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //paypal 和 alipay 打开外部应用
    if ([navigationAction.request.URL.absoluteString containsString:@"paypal.com"] || [navigationAction.request.URL.absoluteString containsString:@"alipay"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:nil completionHandler:^(BOOL success) {
            
        }];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([navigationAction.request.URL.absoluteString containsString:@"payloading"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    }
  
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
