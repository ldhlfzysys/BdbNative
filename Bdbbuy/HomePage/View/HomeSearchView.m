//
//  HomeSearchView.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeSearchView.h"
@implementation HomeSearchView
{
    UIImageView * _backgroundView;
    UIView * _engineBackView;
    UIImageView * _searchImageView;
    UIButton * _searchBtn;
    UITextField * _inputView;
    
}

- (void)clearSearchView
{
    _inputView.text = @"";
}

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
        
        [self createSubviews];
    }
    
    return self;
}

- (void)createSubviews
{
    // 背景图
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundView.image = [UIImage imageNamed:self.backgroundImageName];
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    
    // 引擎背景图
    UIView *engineBackView = [[UIView alloc] init];
    engineBackView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self addSubview:engineBackView];
    [self bringSubviewToFront:engineBackView];
    _engineBackView = engineBackView;
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    [_engineBackView addSubview:searchImageView];
    _searchImageView = searchImageView;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:self.searchButtonText forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [engineBackView addSubview:searchBtn];
    _searchBtn = searchBtn;
    [_searchBtn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *inputView = [[UITextField alloc] init];
    inputView.placeholder = self.placeHolderName;
    inputView.font = [UIFont systemFontOfSize:13];
    [engineBackView addSubview:inputView];
    _inputView = inputView;
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _backgroundView.frame = self.bounds;

    _engineBackView.left = self.seachEngineMargin;
    _engineBackView.height = self.height - 8 * 2;
    _engineBackView.top = 8;
    _engineBackView.width = _backgroundView.width - 2 * self.seachEngineMargin;
    _engineBackView.layer.cornerRadius = 13;
    _engineBackView.layer.masksToBounds = YES;

    _searchImageView.left = 10;
    _searchImageView.width = 18;
    _searchImageView.height = 18;
    _searchImageView.top = (_engineBackView.height - _searchImageView.height) * 0.5;

    [_searchBtn sizeToFit];
    _searchBtn.right = 0;
    _searchBtn.width = 30;
    _searchBtn.top = 0;
    _searchBtn.left = _engineBackView.width - _searchBtn.width - 10;
    _searchBtn.alpha = 1;
    
    CGFloat inputW = _searchBtn.left - _searchImageView.right - 6;
    _inputView.frame = CGRectMake(_searchImageView.right + 5, 0, inputW, _engineBackView.height);

    
}


- (void)searchButtonClick:(UIButton *)btn
{
    [_inputView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(homesearchview:didClickSearchButton:WithSearchText:)]) {
        [self.delegate homesearchview:self didClickSearchButton:btn WithSearchText:_inputView.text];
    }
}

@end
