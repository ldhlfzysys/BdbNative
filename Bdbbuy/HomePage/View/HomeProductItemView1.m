//
//  HomeProductItemView1.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeProductItemView1.h"

@interface HomeProductItemView1 ()
@property (nonatomic, strong) UIButton *productBtn;
@property (nonatomic, strong) UILabel *productLable;
@property (nonatomic, strong) UILabel *priceLable;
@end

static CGFloat spaceMargin = 5;

@implementation HomeProductItemView1

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self createSubviews];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self configSubviews];
}


- (void)createSubviews
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.top = 0;
    btn.left = 0;
    btn.width = self.width;
    btn.height = self.height * 0.5;
    self.productBtn = btn;
    [self addSubview:self.productBtn];
    
    UILabel *productLabel = [[UILabel alloc] init];
    productLabel.top = CGRectGetMaxY(self.productBtn.frame) + spaceMargin;
    productLabel.left = 0;
    productLabel.width = self.width;
    self.productLable = productLabel;
    [self addSubview:self.productLable];
    
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.left = 0;
    priceLabel.bottom = self.height - spaceMargin;
    
    self.priceLable = priceLabel;
    [self addSubview:self.priceLable];
    
    
}

- (void)configSubviews
{
    self.productBtn.top = 0;
    self.productBtn.left = 0;
    
    
    [self.productLable sizeToFit];
    self.productLable.left = 0;
    self.productLable.top = CGRectGetMaxY(self.productBtn.frame) + spaceMargin;
    
    [self.priceLable sizeToFit];
    self.priceLable.left = 0;
    self.priceLable.bottom = self.height - spaceMargin;
    
}


@end
