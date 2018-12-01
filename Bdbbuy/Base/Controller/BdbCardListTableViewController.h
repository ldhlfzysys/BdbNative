//
//  BdbCardListTableViewController.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbTableViewController.h"
#import "BdbCard.h"

NS_ASSUME_NONNULL_BEGIN


@class BdbTableView;
@protocol BdbCardListTableViewControllerDelegate <NSObject>
- (void)didSelectCard:(BdbCard *)card inTableView:(BdbTableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

- (void)didDeSelectCard:(BdbCard *)card inTableView:(BdbTableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end

@interface BdbCardListTableViewController : BdbTableViewController
@property (nonatomic, strong) NSMutableArray<BdbCard *> *cards;
@property (nonatomic, weak) id<BdbCardListTableViewControllerDelegate> cardDelegate;

- (void)refresh;

@end

NS_ASSUME_NONNULL_END
