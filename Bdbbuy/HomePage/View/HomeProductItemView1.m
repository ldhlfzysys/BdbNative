//
//  HomeProductItemView1.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeProductItemView1.h"
#import "UIImageView+WebCache.h"

@interface HomeProductItemView1 ()

@property (nonatomic, strong) UIButton *backgroundButton;
@property (nonatomic, strong) UIImageView *productImage;
@property (nonatomic, strong) UILabel *productLable;
@property (nonatomic, strong) UILabel *priceLable;
@end

static CGFloat spaceMargin = 5;

@implementation HomeProductItemView1

- (void)configProductViewWithProductImage:(NSString *)productImageName WithProductName:(NSString *)productName WithProductFont:(UIFont *)productFont  WithPrice:(NSString *)price WithPriceFont:(UIFont *)priceFont
{
    [self configProductViewWithProductImage:productImageName WithProductName:productName WithPrice:price];
    self.productLable.font = productFont;
    self.priceLable.font = priceFont;
    [self configSubviews];
}

- (void)configProductViewWithProductImage:(NSString *)productImageName WithProductName:(NSString *)productName WithPrice:(NSString *)price
{
    if ([productName hasPrefix:@"http"]) {
        [self.productImage sd_setImageWithURL:[NSURL URLWithString:productImageName]];
    } else {
        [self.productImage setImage:[UIImage imageNamed:productImageName]];
    }
    
    
    
    self.productLable.font = [UIFont systemFontOfSize:11];
    self.productLable.numberOfLines = 2;
    self.productLable.text = productName;
    [self.productLable sizeToFit];
    self.productLable.lineBreakMode = NSLineBreakByTruncatingTail;
    self.priceLable.text = price;
    self.priceLable.font = [UIFont systemFontOfSize:13];
    self.priceLable.textColor = [UIColor redColor];
    
    [self configSubviews];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundButton = backBtn;
    [self addSubview:self.backgroundButton];
    [self.backgroundButton addTarget:self action:@selector(productButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.productImage = imageView;
    [backBtn addSubview:self.productImage];
    
    UILabel *productLabel = [[UILabel alloc] init];
    self.productLable = productLabel;
    productLabel.width = self.backgroundButton.width;
    [backBtn addSubview:self.productLable];
    
    
    UILabel *priceLabel = [[UILabel alloc] init];
    self.priceLable = priceLabel;
    [backBtn addSubview:self.priceLable];
    
}

- (void)configSubviews
{
    self.backgroundButton.frame = self.bounds;
    
    self.productImage.top = 0;
    self.productImage.left = 0;
    self.productImage.width = self.backgroundButton.width;
    self.productImage.height = self.backgroundButton.height * 0.6;
    
    [self.productLable sizeToFit];
    self.productLable.left = 0;
    self.productLable.top = CGRectGetMaxY(self.productImage.frame) + spaceMargin;
    self.productLable.width = self.backgroundButton.width;
    
    [self.priceLable sizeToFit];
    self.priceLable.left = 0;
    self.priceLable.width = self.backgroundButton.width;
    self.priceLable.bottom = self.height - spaceMargin;
    
}

- (void)productButtonClick:(UIButton *)btn
{
    
}


@end
