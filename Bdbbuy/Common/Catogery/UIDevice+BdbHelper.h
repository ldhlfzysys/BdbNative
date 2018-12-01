//
//  UIDevice+BdbHelper.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BDB_ScreenType)
{
    BDB_ScreenTypeUndefined = 0,
    BDB_ScreenTypeClassic = 1,//3gs及以下
    BDB_ScreenTypeRetina = 2,//4&4s
    BDB_ScreenType4InchRetina = 3,//5&5s&5c
    BDB_ScreenType6 = 4,//6或者6+放大模式
    BDB_ScreenType6Plus = 5,//6+
    BDB_ScreenTypeIpadClassic = 6,//iPad 1,2,mini
    BDB_ScreenTypeIpadRetina = 7,//iPad 3以上,mini2以上
    BDB_ScreenTypeIpadPro = 8,//iPad Pro
    BDB_ScreenTypeIphoneX = 9,//x xs
    BDB_ScreenTypeIphoneXSM  = 10,//xsm xr
    BDB_ScreenTypeIpadProNoTouchID = 11 //new ipad pro without touchID
};

@interface UIDevice (BdbHelper)

- (BDB_ScreenType)screenType;
- (BOOL)bdb_isIPad;
- (BOOL)bdb_isIPadClassic;
- (BOOL)bdb_isIPadRetina;
- (BOOL)bdb_isIPadPro;

@end

NS_ASSUME_NONNULL_END
