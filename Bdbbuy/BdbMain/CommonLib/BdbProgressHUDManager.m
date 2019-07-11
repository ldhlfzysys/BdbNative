
#import "BdbProgressHUDManager.h"

@implementation BdbProgressHUDManager
- (void)setBackgroundColor:(UIColor *)color{
    [SVProgressHUD setBackgroundColor:color];
}
- (void)showImage:(UIImage *)image string:(NSString *)string{
    [SVProgressHUD showImage:image status:string];
}
@end
