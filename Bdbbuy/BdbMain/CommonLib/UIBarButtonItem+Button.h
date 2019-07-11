

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ItemButtonType) {
    LeftItemButton,
    RightItemButton
};

@interface UIBarButtonItem (Button)

+ (instancetype)barButtonItem:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action type:(ItemButtonType)type;


@end
