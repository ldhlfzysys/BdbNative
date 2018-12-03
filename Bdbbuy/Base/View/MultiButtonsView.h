//
//  MultiButtonsView.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface ButtonInfo : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, copy) NSString *normalImageName;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *placeHolderImage;
@property (nonatomic, copy) NSString *hilightedImageName;
@property (nonatomic, assign, getter=isVertical) BOOL vertical;


@end

@interface MultiButtonsView : UIView
@property (nonatomic, assign) int maxLineCount; // 一行布局最大button数,最大不能超过6个
@property (nonatomic, copy) NSArray<ButtonInfo *> *buttonInfos;
- (instancetype)initWithFrame:(CGRect)frame WithButtonInfos:(NSArray<ButtonInfo *> *)buttonInfos WithMaxLineCount:(int)maxLineCount;
@end

NS_ASSUME_NONNULL_END
