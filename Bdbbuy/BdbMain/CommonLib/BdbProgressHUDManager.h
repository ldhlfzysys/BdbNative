
#import <SVProgressHUD/SVProgressHUD.h>

@interface BdbProgressHUDManager : SVProgressHUD

- (void)setBackgroundColor:(UIColor *)color;
- (void)showImage:(UIImage *)image string:(NSString *)string;
@end
