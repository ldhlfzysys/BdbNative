//
//  HomeSearchView.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeSearchView : UIView
@property (nonatomic, assign) NSInteger seachViewHeight;
@property (nonatomic, assign) NSInteger seachEngineMargin;
@property (nonatomic, strong) NSString *backgroundImageName;
@property (nonatomic, strong) NSString *placeHolderName;
@property (nonatomic, strong) NSString *searchButtonText;

- (instancetype)initWithSeachEngineMargin:(NSInteger)margin
                  WithBackgroundImageName:(NSString *)imageName
                      WithplaceHolderName:(NSString *)placeHolderName
                     WithSearchButtonText:(NSString *)searchButtonText;
@end

NS_ASSUME_NONNULL_END
