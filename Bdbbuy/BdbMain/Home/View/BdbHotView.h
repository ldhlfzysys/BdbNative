
#import <UIKit/UIKit.h>

@interface BdbHotView : UIView
- (instancetype)initWithImages:(NSArray<NSString *> *)images title:(NSArray *)titles placeHolder:(UIImage *)image;
@property (nonatomic, copy) ClikedCallback callback;

@end
