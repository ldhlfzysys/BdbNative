//
//  UIButton+ImageTileSpacing.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/5.
//  Copyright © 2018 bdbbuy. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, BDBButtonEdgeInsetsStyle) {
    BDBButtonEdgeInsetsStyleTop, // image在上，label在下
    BDBButtonEdgeInsetsStyleLeft, // image在左，label在右
    BDBButtonEdgeInsetsStyleBottom, // image在下，label在上
    BDBButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (ImageTileSpacing)
- (void)layoutButtonWithEdgeInsetsStyle:(BDBButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
