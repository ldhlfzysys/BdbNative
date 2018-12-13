//
//  BdbTabBarViewController.h
//  Bdbbuy
//
//  Created by donghuan1 on 2018/11/30.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BdbTabBarViewController : UITabBarController
- (NSInteger)getTabbarItemIndexWithTabbarTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
