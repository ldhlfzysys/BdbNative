//
//  HomeProductView.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeProductView;
@protocol HomeProductViewDelegate <NSObject>

- (void)homeproductview:(HomeProductView *)hpView didSelectHeaderButton:(UIButton *)btn WithHeaderURL:(NSString *)url;
-(void)homeproductview:(HomeProductView *)hpView collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath WithProductURL:(NSString *)url;

@end

@interface HomeProductView : UIView
@property (nonatomic, strong) NSString *headerButtonImageName;
@property (nonatomic, strong) NSArray<BdbCard *> *products;
@property (nonatomic, assign) BOOL scrollEnable;
@property (nonatomic, assign) CGFloat collectionViewHeight;
@property (nonatomic, assign) CGFloat headerBtnHeight;
@property (nonatomic, copy) NSString *headerURL;
@property (nonatomic, weak) id<HomeProductViewDelegate> delegate;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;


// 只允许使用当前构造方法
- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowlayout;

- (CGFloat)getViewHeight;
@end

