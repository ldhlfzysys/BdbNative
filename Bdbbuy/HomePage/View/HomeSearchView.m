//
//  HomeSearchView.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeSearchView.h"

@implementation HomeSearchView
- (instancetype)initWithSeachEngineMargin:(NSInteger)margin
                 WithBackgroundImageName:(NSString *)imageName
                     WithplaceHolderName:(NSString *)placeHolderName
                    WithSearchButtonText:(NSString *)searchButtonText
{
    self = [super init];
    if (self) {
        self.seachEngineMargin = margin;
        self.backgroundImageName = imageName;
        self.placeHolderName = placeHolderName;
        self.searchButtonText = searchButtonText;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 背景图
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundView.image = [UIImage imageNamed:self.backgroundImageName];
    [self addSubview:backgroundView];
    
    // 引擎背景图
    UIView *engineBackView = [[UIView alloc] init];
    engineBackView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];

    engineBackView.left = self.seachEngineMargin;
    engineBackView.height = self.height - 8 * 2;
    engineBackView.top = 8;
    engineBackView.width = backgroundView.width - 2 * self.seachEngineMargin;
    engineBackView.layer.cornerRadius = 13;
    engineBackView.layer.masksToBounds = YES;
    [self addSubview:engineBackView];
    [self bringSubviewToFront:engineBackView];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    searchImageView.left = 0;
    searchImageView.top = 0;
    searchImageView.width = 30;
    [engineBackView addSubview:searchImageView];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:self.searchButtonText forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [searchBtn sizeToFit];
    searchBtn.right = 0;
    searchBtn.width = 50;
    searchBtn.top = 0;
    searchBtn.left = engineBackView.width - searchBtn.width;
    searchBtn.alpha = 1;
    [engineBackView addSubview:searchBtn];
    CGFloat inputW = searchBtn.left - searchImageView.right - 4;
    UITextField *inputView = [[UITextField alloc] initWithFrame:CGRectMake(searchImageView.right + 2, 0, inputW, engineBackView.height)];
    [engineBackView addSubview:inputView];
    
}

@end
