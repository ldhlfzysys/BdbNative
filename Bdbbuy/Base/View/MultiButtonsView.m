//
//  MultiButtonsView.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "MultiButtonsView.h"
#import "UIButton+WebCache.h"

static int minLineCount = 2;
static int maxLineCount = 6;

@interface MultiButton : UIButton

@end
@implementation MultiButton



@end


@interface ButtonInfo () <NSCoding>
//+ima
@end

@implementation ButtonInfo

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.normalImageName = [aDecoder decodeObjectForKey:@"normalImageName"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.placeHolderImage = [aDecoder decodeObjectForKey:@"placeHolderImage"];
        self.hilightedImageName = [aDecoder decodeObjectForKey:@"hilightedImageName"];
        self.vertical = [aDecoder decodeBoolForKey:@"vertical"];
        self.titleColor = [aDecoder decodeObjectForKey:@"titleColor"];
        self.titleFont = [aDecoder decodeObjectForKey:@"titleFont"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.normalImageName forKey:@"normalImageName"];
    [coder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [coder encodeObject:self.placeHolderImage forKey:@"placeHolderImage"];
    [coder encodeObject:self.hilightedImageName forKey:@"hilightedImageName"];
    [coder encodeBool:self.vertical forKey:@"vertical"];
    [coder encodeObject:self.titleColor forKey:@"titleColor"];
    [coder encodeObject:self.titleFont forKey:@"titleFont"];
    
}

- (BOOL)isVertical
{
    if (!_vertical) {
        _vertical = NO;
    }
    return _vertical;
}

@end


@implementation MultiButtonsView
- (instancetype)initWithFrame:(CGRect)frame WithButtonInfos:(NSArray<ButtonInfo *> *)buttonInfos WithMaxLineCount:(int)maxLineCount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonInfos = buttonInfos;
        self.maxLineCount = maxLineCount;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.maxLineCount <= minLineCount) {
        self.maxLineCount = minLineCount;
    }
    if (self.maxLineCount > maxLineCount) {
        self.maxLineCount = maxLineCount;
    }
    
    CGFloat buttonW = (CGFloat)self.width / self.maxLineCount;
    CGFloat buttonH = self.height / ceil((float)self.buttonInfos.count / self.maxLineCount);
    
    for (int i = 0; i < self.buttonInfos.count; i++) {
        ButtonInfo *info = self.buttonInfos[i];
        MultiButton *btn = [MultiButton buttonWithType:UIButtonTypeCustom];
        if (info.title) {
            [btn setTitle:info.title forState:UIControlStateNormal];
        }
        if (info.normalImageName) {
            if ([info.normalImageName hasPrefix:@"http"]) {
                NSURL *url = [NSURL URLWithString:info.normalImageName];
                [btn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:info.placeHolderImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (info.isVertical) {
                        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                        btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
                        CGFloat margin = 5;
                        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.width, -btn.imageView.height - margin, 0);
                        btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.height - margin, 0, 0, -btn.titleLabel.width);
                    }
                }];
            } else {
                [btn setImage:[UIImage imageNamed:info.normalImageName] forState:UIControlStateNormal];
            }
            
            if (info.hilightedImageName) {
                if ([info.hilightedImageName hasPrefix:@"http"]) {
                    NSURL *url = [NSURL URLWithString:info.hilightedImageName];
                    [btn sd_setImageWithURL:url forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:info.placeHolderImage]];
                } else
                {
                    [btn setImage:[UIImage imageNamed:info.hilightedImageName] forState:UIControlStateHighlighted];
                }
            }
        }
        
        if (info.imageUrl) {
            NSURL *url = [NSURL URLWithString:info.imageUrl];
            [btn sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:info.placeHolderImage]];
        }
        if (info.titleColor) {
            [btn setTitleColor:info.titleColor forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        btn.titleLabel.font = info.titleFont ? : [UIFont systemFontOfSize:10];
        
        [btn sizeToFit];
        
        btn.height = buttonH;
        btn.width = buttonW;
        btn.left = (i % self.maxLineCount) * buttonW;
        btn.top = (i / self.maxLineCount) * buttonH;
        
        if (info.isVertical) {
            [btn layoutButtonWithEdgeInsetsStyle:BDBButtonEdgeInsetsStyleTop imageTitleSpace:5];
        }
        
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    

}


- (void)buttonClick:(UIButton *)btn
{
    NSLog(@"%@", btn);
    NSInteger index = (btn.y / btn.height) * self.maxLineCount + (btn.x / btn.width);
    if ([self.delegate respondsToSelector:@selector(multibuttonsview:DidSelectButton:)]) {
        [self.delegate multibuttonsview:self DidSelectButton:index];
    }
}



@end