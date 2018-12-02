//
//  BdbWebViewController.h
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BdbWebViewController : BaseViewController
@property(nonatomic,strong)WKWebView *webview;
@property (nonatomic, strong) UIProgressView *progressView;
- (void)load:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
