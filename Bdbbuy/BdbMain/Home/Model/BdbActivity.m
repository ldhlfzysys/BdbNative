
#import "BdbActivity.h"

@implementation HeadResource

+ (void)loadHeadData:(CompleteBlock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页焦点按钮" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    HeadResource *headResource = [HeadResource mj_objectWithKeyValues:json];
    complete(headResource.data,nil);
}

@end

@implementation HeadData

+ (NSDictionary *)mj_objectClassInArray {
    return  @{
              @"focus":NSStringFromClass([BdbActivity class]),
              @"activities":NSStringFromClass([BdbActivity class]),
              @"icons":NSStringFromClass([BdbActivity class])
              };
}



@end

@implementation BdbActivity
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"aid":@"id"};
}
@end

@implementation ExtParams

@end
