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
        
        UIEdgeInsets area = [self safeAreaInsets];
        area.top += 44;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, area.top, self.view.frame.size.width, self.view.frame.size.height - area.top) configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [self.view addSubview:_webView];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://bdbbuy.com"]]];
        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"地址" style:UIBarButtonItemStylePlain target:self action:@selector(editAddrss)];
    }
    return self;
}

- (UIEdgeInsets)safeAreaInsets;
{
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
    }else{
        safeAreaInsets.top = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    safeAreaInsets.top = MAX(20, safeAreaInsets.top);
    return safeAreaInsets;
}

- (void)editAddrss
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入地址" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      //获取第1个输入框；
      UITextField *userNameTextField = alertController.textFields.firstObject;
        NSString *text = userNameTextField.text;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:text]]];
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
      
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
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
