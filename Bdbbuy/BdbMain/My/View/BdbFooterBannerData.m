
#import "BdbFooterBannerData.h"

@implementation BdbFooterBannerData
+ (void)loadFootBannerData:(CompleteBlock)comple{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"footerBanner" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    BdbFooterBannerData *footerData = [BdbFooterBannerData mj_objectWithKeyValues:dict];
    comple(footerData.data,nil);
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"data": NSStringFromClass([BdbActivity class])
             };
}
@end
