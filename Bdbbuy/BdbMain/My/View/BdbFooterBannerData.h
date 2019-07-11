
#import <Foundation/Foundation.h>
#import "BdbActivity.h"

@interface BdbFooterBannerData : NSObject
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,copy) NSArray<BdbActivity *> *data;
+ (void)loadFootBannerData:(CompleteBlock)comple;
@end
