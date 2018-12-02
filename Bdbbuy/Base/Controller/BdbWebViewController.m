//
//  BdbWebViewController.m
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbWebViewController.h"

@interface BdbWebViewController ()

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
    return self;
}

@end
