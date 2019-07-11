
#import <Foundation/Foundation.h>
#include "BdbHomeHeadData.h"
#import "BdbScrollerPageView.h"
#import "BdbHeadLineView.h"
#import "BdbHotView.h"

@interface BdbHomeHeadView : UIView
@property (nonatomic, strong) BdbScrollerPageView *scrollerView;
@property (nonatomic, strong) BdbHotView *hotView;
@property (nonatomic, strong) BdbHeadLineView *headlineView;
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithHeadData:(BdbHomeHeadData *)headData;
@property (nonatomic, copy) ClikedCallback callback;



@end
