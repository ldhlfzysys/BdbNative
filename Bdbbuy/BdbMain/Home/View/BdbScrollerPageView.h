
#import <UIKit/UIKit.h>

@interface BdbScrollerPageView : UIView

@property (nonatomic, copy) ClikedCallback clikeCall;
+ (instancetype)pageScroller:(NSArray <NSString *>*)images placeHolderImage:(UIImage *)placeHolderImage;

@end
