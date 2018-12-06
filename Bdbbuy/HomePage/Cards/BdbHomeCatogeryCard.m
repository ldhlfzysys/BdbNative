//
//  BdbHomeCatogeryCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbHomeCatogeryCard.h"
#import "MultiButtonsView.h"


static NSUInteger CatogeryHeight = 150;
@implementation BdbHomeCatogeryCard
- (UIView *)viewWithCardData:(NSDictionary *)data
{
    NSArray *dataArr = [data objectForKey:@"data"];
    NSMutableArray *buttonInfoArr = [NSMutableArray array];
    
    for (int i = 0; i < dataArr.count; i++)
    {
        NSDictionary *catagoryDic = dataArr[i];
        ButtonInfo *info = [[ButtonInfo alloc] init];
        info.title = catagoryDic[@"name"];
        info.normalImageName = catagoryDic[@"image"];
        info.placeHolderImage = @"user";
        info.vertical = YES;
        [buttonInfoArr addObject:info];
    }
    int maxLineCount = 5;
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    MultiButtonsView *multiButtonView = [[MultiButtonsView alloc] initWithFrame:CGRectMake(0,0,cellWidth,CatogeryHeight) WithButtonInfos:buttonInfoArr  WithMaxLineCount:maxLineCount];
    multiButtonView.delegate = self.delegate;
    return multiButtonView;
}

- (CGFloat)computeCardHeight
{
    return CatogeryHeight;
}
@end