//
//  Global.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#ifndef Global_h
#define Global_h

#import <UIKit/UIKit.h>

#import "BdbNetwork.h"

extern NSString * const HomeTableHeadViewHeightDidChange;
extern NSString * const HomeGoodsInventoryProblem;
extern NSString * const LFBShopCarDidRemoveProductNSNotification;
extern NSString * const LFBShopCarBuyNumberDidChangeNotification;
extern NSString * const GuideViewControllerDidFinish;
extern NSString * const IsFirstOpenApp;
extern const CGFloat HomeCollectionViewCellMargin;
extern const CGFloat DefaultMargin;

#import "Masonry.h"
#import "SVProgressHUD.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "BdbAnimationRefreshHeader.h"
#import "BaseTabBarViewController.h"


typedef NS_ENUM(NSInteger ,HeadViewItemType){
    HeadViewItemTypePage,
    HeadViewItemTypeHot,
    HeadViewItemTypeHeadLine,
    HeadViewItemTypeBrand,
    HeadViewItemTypeScene
};
typedef void (^CompleteBlock)(id data,NSError *error);
typedef void(^ClikedCallback) (HeadViewItemType type,NSInteger tag);


#define Width  [[UIScreen mainScreen] bounds].size.width
#define Height [[UIScreen mainScreen] bounds].size.height
#define GrayColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define GrayColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define GeneralColor [UIColor colorWithRed:0.992 green:0.831 blue:0.192 alpha:1.000]
#endif /* PrefixHeader_h */
