

#import <UIKit/UIKit.h>
#import "BdbHomeHeadData.h"

@interface BdbHeadLineView : UIView
@property (nonatomic, strong) ActInfo *headline;
@property (nonatomic, copy) ClikedCallback callback;
@end
