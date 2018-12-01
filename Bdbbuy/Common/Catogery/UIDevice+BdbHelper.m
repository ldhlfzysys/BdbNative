//
//  UIDevice+BdbHelper.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "UIDevice+BdbHelper.h"
#include <sys/sysctl.h>

@implementation UIDevice (BdbHelper)



- (BDB_ScreenType)screenType
{
    
    static BDB_ScreenType screenType = BDB_ScreenTypeUndefined;
    
#if TARGET_IPHONE_SIMULATOR
    if (screenType == BDB_ScreenTypeIpadPro && [UIApplication sharedApplication].keyWindow) {
        if (@available(iOS 12.0, *)) {
            double bottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
            if(bottom > 0) {
                screenType = BDB_ScreenTypeIpadProNoTouchID;
                return screenType;
            }
        }
    }
#endif
    if (screenType == BDB_ScreenTypeUndefined) {
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        int height = MAX(screenBounds.size.width, screenBounds.size.height);
        int width = MIN(screenBounds.size.width, screenBounds.size.height);
        
        int scale = [[UIScreen mainScreen] scale];
        
        if (height == 480 && width == 320) {
            if (scale == 1) {
                screenType = BDB_ScreenTypeClassic;
            } else if (scale == 2){
                screenType = BDB_ScreenTypeRetina;
            }
        } else if (height == 568 && width == 320){
            screenType = BDB_ScreenType4InchRetina;
        } else if (height == 667 && width == 375){
            screenType = BDB_ScreenType6;
        } else if (height == 736 && width == 414){
            screenType = BDB_ScreenType6Plus;
        } else if (height == 1024 && width == 768) {
            if (scale == 1){
                screenType = BDB_ScreenTypeIpadClassic;
            } else if (scale == 2) {
                screenType = BDB_ScreenTypeIpadRetina;
            }
        } else if (height == 1112 && width == 834) {
            screenType = BDB_ScreenTypeIpadPro;
        } else if (height == 1366 && width == 1024) {
            screenType = [self bdb_is3thIpadPro] ? BDB_ScreenTypeIpadProNoTouchID : BDB_ScreenTypeIpadPro;
        } else if (height == 812 && width == 375) {
            screenType = BDB_ScreenTypeIphoneX;
        } else if (height == 896 && width == 414) {
            screenType = BDB_ScreenTypeIphoneXSM;
        } else if (height == 1194 && width == 834) {
            screenType = BDB_ScreenTypeIpadProNoTouchID;
        }
    }
    return screenType;
}


- (BOOL)bdb_is3thIpadPro {
    return [@[@"iPad8,5",@"iPad8,6",@"iPad8,7",@"iPad8,8"] containsObject: [UIDevice bdb_platform]];
}

- (BOOL)bdb_isIPad
{
    return ([self bdb_isIPadClassic] || [self bdb_isIPadRetina] || [self bdb_isIPadPro]);
}


- (BOOL)bdb_isIPadClassic
{
    return [self screenType] == BDB_ScreenTypeIpadClassic;
}

- (BOOL)bdb_isIPadRetina
{
    return [self screenType] == BDB_ScreenTypeIpadRetina;
}

- (BOOL)bdb_isIPadPro
{
    return [self screenType] == BDB_ScreenTypeIpadPro || [self screenType] == BDB_ScreenTypeIpadProNoTouchID;
}

+ (NSString *) bdb_platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
@end
