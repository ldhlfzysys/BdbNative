//
//  HomePageTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/3.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderToolScrollBar;

@protocol HeaderToolBarDelegate <NSObject>

/**
 *  点击按钮事件，返回当前按钮的标题和下标
 *
 *  @param title         按钮标题
 *  @param index         按钮下标
 */
- (void)HeaderToolScrollBar:(HeaderToolScrollBar *)headerToolBar didSelectItemWithTitle:(NSString *)title withIndex:(NSInteger)index;

@end


@interface HeaderToolScrollBar : UIScrollView

/**
 *  配置显示的标题
 *
 *  @param titleAry 标题数组
 */
- (void)configWithTitleArray:(NSArray *)titleAry MaxShowNum:(NSInteger)maxNum;

/**
 *  设置被选中的item
 */
- (void)changeSelectItemWithIndex:(NSInteger)index;

@property (nonatomic, weak) id<HeaderToolBarDelegate> customDelegate;

@end
