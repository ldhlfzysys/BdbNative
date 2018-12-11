//
//  BdbHomeProductCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbHomeProductCard.h"
#import "HomeProductItemView1.h"

@implementation BdbHomeProductCard

- (UIView *)viewWithCardData:(NSDictionary *)data
{
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    CGFloat cellHeight = [data objectForKey:@"cellHeight"] ? [[data objectForKey:@"cellHeight"] floatValue] : 50;
    HomeProductItemView1 *view = [[HomeProductItemView1 alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
    
    [self refreshView:view WithData:data];
    return view;
}

-(void)refreshView:(UIView *)view WithData:(NSDictionary *)data
{
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    CGFloat cellHeight = [data objectForKey:@"cellHeight"] ? [[data objectForKey:@"cellHeight"] floatValue] : 50;
    HomeProductItemView1 *productView = (HomeProductItemView1 *)view;
    productView.frame = CGRectMake(0, 0, cellWidth, cellHeight);
    NSString *price = [NSString stringWithFormat:@"CA$%@",[self stringDisposeWithFloat:[[data objectForKey:@"price"] floatValue]]];
    UIFont *productFont = [UIFont systemFontOfSize:[[data objectForKey:@"productFontSize"] floatValue]];
    UIFont *priceFont = [UIFont systemFontOfSize:[[data objectForKey:@"priceFontSize"] floatValue]];
    [productView configProductViewWithProductImage:[data objectForKey:@"image"] WithProductName:[data objectForKey:@"name"] WithProductFont:productFont WithPrice:price WithPriceFont:priceFont];
    
}


//浮点数处理并去掉多余的0
-(NSString *)stringDisposeWithFloat:(float)floatValue
{
    NSString *str = [NSString stringWithFormat:@"%f",floatValue];
    long len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        //s.substring(0, len - i - 1);
        return [str substringToIndex:[str length]-1];
    }
    else
    {
        return str;
    }
}

@end
