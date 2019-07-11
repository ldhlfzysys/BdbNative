
#import <Foundation/Foundation.h>

@class SuperMarketData;
@class Products;
@class ProductCategory;
@class BdbGoods;

@interface BdbSupermarketSource : NSObject

/** code  */
@property (nonatomic, copy) NSString *code;
/** msg  */
@property (nonatomic, copy) NSString *msg;
/** data  */
@property (nonatomic,strong)SuperMarketData *data;

+ (void)loadSupermarketData:(CompleteBlock)complete;
@end

@interface SuperMarketData : NSObject

@property (nonatomic,strong)NSArray<ProductCategory *> *categories;

@property (nonatomic,strong)id products;

@end

@interface ProductCategory : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, strong) NSArray <BdbGoods *> *products;
@end
