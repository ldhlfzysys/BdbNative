//
//  HomeProductView.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface HomeProductView : UIView
@property (nonatomic, strong) NSString *headerButtonImageName;
@property (nonatomic, strong) NSArray<BdbCard *> *products;
@property (nonatomic, assign) BOOL scrollEnable;
@property (nonatomic, assign) CGFloat collectionViewHeight;
@property (nonatomic, assign) CGFloat headerBtnHeight;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


// 只允许使用当前构造方法
- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowlayout;

- (CGFloat)getViewHeight;
@end

