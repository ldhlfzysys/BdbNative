//
//  HomeProductItemView1.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeProductItemView1 : UIView

- (void)configProductViewWithProductImage:(NSString *)productImageName WithProductName:(NSString *)productName WithPrice:(NSString *)price;
- (void)configProductViewWithProductImage:(NSString *)productImageName WithProductName:(NSString *)productName WithProductFont:(UIFont *)productFont  WithPrice:(NSString *)price WithPriceFont:(UIFont *)priceFont;

@end

NS_ASSUME_NONNULL_END
