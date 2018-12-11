//
//  BdbHomeCatogeryCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbHomeCatogeryCard.h"
#import "MultiButtonsView.h"


static NSUInteger CatogeryHeight = 130;
@implementation BdbHomeCatogeryCard
- (UIView *)viewWithCardData:(NSDictionary *)data
{
    NSArray *dataArr = [data objectForKey:@"data"];
    NSMutableArray *buttonInfoArr = [NSMutableArray array];
    
    for (int i = 0; i < dataArr.count;  i++)
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
    CGFloat margin = 10;
    MultiButtonsView *multiButtonView = [[MultiButtonsView alloc] initWithFrame:CGRectMake(margin,0,cellWidth - 2 * margin,CatogeryHeight) WithButtonInfos:buttonInfoArr  WithMaxLineCount:maxLineCount];
    multiButtonView.delegate = self.delegate;
    return multiButtonView;
}

-(void)refreshView:(UIView *)view WithData:(NSDictionary *)data
{
    NSArray *dataArr = [data objectForKey:@"data"];
    NSMutableArray *buttonInfoArr = [NSMutableArray array];
    
    for (int i = 0; i < dataArr.count;  i++)
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
    CGFloat margin = 10;
    view.frame = CGRectMake(margin,0,cellWidth - 2 * margin,CatogeryHeight);
    ((MultiButtonsView *)view).maxLineCount = maxLineCount;
    ((MultiButtonsView *)view).buttonInfos = buttonInfoArr;
    ((MultiButtonsView *)view).delegate = self.delegate;
}

- (CGFloat)computeCardHeight
{
    return CatogeryHeight;
}
@end
