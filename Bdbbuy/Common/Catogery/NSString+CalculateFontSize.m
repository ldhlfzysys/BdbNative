//
//  HomePageTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/3.
//  Copyright © 2018 bdbbuy. All rights reserved.
//


#import "NSString+CalculateFontSize.h"

@implementation NSString (CalculateFontSize)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
