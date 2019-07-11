

#import "BdbTitleIconAction.h"

@implementation BdbTitleIconAction
+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controlller tag:(NSInteger )tag{
    BdbTitleIconAction *titleIconAction = [[BdbTitleIconAction alloc]init];
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controlller;
    titleIconAction.tag = tag;
    return titleIconAction;
}
@end
