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
    return view;
}
@end
