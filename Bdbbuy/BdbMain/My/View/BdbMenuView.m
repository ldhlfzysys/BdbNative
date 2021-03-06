
#import "BdbMenuView.h"
#import "BdbTitleIconView.h"

@interface BdbMenuView ()
@property (nonatomic, strong) NSArray *mens;
@end

@implementation BdbMenuView

static const NSInteger DefaultRowNumbers = 4;

- (instancetype)initMenu:(NSArray <BdbTitleIconAction *>*)mens WithLine:(BOOL)line{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.mens = mens;
        for (BdbTitleIconAction *title in mens) {
            BdbTitleIconView *titleIconView = [[BdbTitleIconView alloc]initWithTitleLabel:title.title icon:title.icon boder:line];
            titleIconView.tag = title.tag;
            titleIconView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewClick)];
            [titleIconView addGestureRecognizer:tap];
            [self addSubview:titleIconView];
        }
    }
    return self;
}

- (void)titleIconViewClick{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width / DefaultRowNumbers;
    CGFloat height = self.bounds.size.height / (self.mens.count / DefaultRowNumbers);
    
    for (int i = 0; i < self.subviews.count; ++i) {
        BdbTitleIconView *titleIconView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers) * width;
        CGFloat viewY = (i / DefaultRowNumbers) * height;
        titleIconView.frame = CGRectMake(viewX, viewY, width, height);
    }
    
}


@end
