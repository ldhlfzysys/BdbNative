//
//  CommonDefine.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "UIDevice+BdbHelper.h"

#ifndef CommonDefine_h
#define CommonDefine_h

#define BdbAvalibleOS(os_version)    ([[[UIDevice currentDevice] systemVersion] intValue] >= os_version)

#define BdbStatusBarHeight   (([[UIDevice currentDevice] screenType] == BDB_ScreenTypeIphoneX || [[UIDevice currentDevice] screenType] == BDB_ScreenTypeIphoneXSM) ? 44.f : ([[UIDevice currentDevice] screenType] == BDB_ScreenTypeIpadProNoTouchID) ? 24.f : 20.f)
#define BdbNaivationBarHeight ([[UIDevice currentDevice] bdb_isIPad] ? (BdbAvalibleOS(12) ? 50.f : 44.f) : 44.f)
#define BdbDefaultTableViewBaseInsetTop (BdbNaivationBarHeight + BdbStatusBarHeight)

#endif /* CommonDefine_h */
