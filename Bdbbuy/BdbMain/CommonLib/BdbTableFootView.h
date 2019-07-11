
#import <UIKit/UIKit.h>


@protocol BdbTableFootViewDelegate <NSObject>
- (void)didTableFootViewCommit;
@end

@interface BdbTableFootView : UIView
@property (nonatomic, weak) id<BdbTableFootViewDelegate>delegate ;
@property (nonatomic, assign) CGFloat sumMoney;
@property (nonatomic, strong) UIButton *commitBtn;
@end
