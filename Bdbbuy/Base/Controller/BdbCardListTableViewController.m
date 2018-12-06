//
//  BdbCardListTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbCardListTableViewController.h"
#import "BdbCardTableViewCell.h"



@interface BdbCardListTableViewController ()

@end

@implementation BdbCardListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cards = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

#pragma mark - public
- (void)refresh
{
    [self.tableView reloadData];
}


#pragma mark - setter and getter
- (void)setCards:(NSMutableArray<BdbCard *> *)cards
{
    _cards = cards;
    [self refresh];
}

#pragma mark - deledate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cards.count;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    BdbCard *card = [_cards objectAtIndex:section];
    if ([card isKindOfClass:[BdbMultiCard class]]) {
        return ((BdbMultiCard *)card).subcards.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BdbCard *card = [_cards objectAtIndex:indexPath.section];
    if ([card isKindOfClass:[BdbMultiCard class]]) {
        card = [((BdbMultiCard *)card).subcards objectAtIndex:indexPath.row];
    }
    
    NSString *reuseId = (card.cardClassID && NSClassFromString(card.cardClassID) != nil) ? card.cardClassID : NSStringFromClass([card class]);
    
    BdbCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        card.delegate = self;
        if (card.cardClassID && NSClassFromString(card.cardClassID) != nil)
        {
            Class cardClass = NSClassFromString(card.cardClassID);
            NSAssert(![cardClass isKindOfClass:[BdbCardTableViewCell class]], @"Please use BdbCardTableViewCell");
            cell = [[cardClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId cellCard:card];
            cell.contentView.frame = cell.bounds;
        } else {
            cell = [[BdbCardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId cellCard:card];
            cell.contentView.frame = cell.bounds;
            if (![card conformsToProtocol:@protocol(BdbCardProtocol)]) {
                return nil;
            }
            id<BdbCardProtocol> cellCard = card;
            NSMutableDictionary *datadic = [NSMutableDictionary dictionaryWithDictionary:card.dataDic];
            [datadic setObject:@(cell.contentView.width) forKey:@"cellWidth"];
            UIView *cardView = [cellCard viewWithCardData:datadic];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:cardView];
            
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BdbCard *card = [_cards objectAtIndex:indexPath.section];
    if ([card isKindOfClass:[BdbMultiCard class]]) {
        card = [((BdbMultiCard *)card).subcards objectAtIndex:indexPath.row];
    }
    
    if (!card.cardHeight || card.cardHeight <= 0) {
        if (card.cardClassID && card.cardClassID.length > 0) {
            card.cardHeight = [NSClassFromString(card.cardClassID) computeCellHeight];
        } else
        {
            card.cardHeight = [card computeCardHeight];
        }
        
    }
    return card.cardHeight < 0 ? 0 : card.cardHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BdbCard *card = [_cards objectAtIndex:indexPath.section];
    if ([card isKindOfClass:[BdbMultiCard class]]) {
        card = [((BdbMultiCard *)card).subcards objectAtIndex:indexPath.row];
    }
    if ([self.cardDelegate respondsToSelector:@selector(didSelectCard:inTableView:atIndexPath:)]) {
        [self.cardDelegate didSelectCard:card inTableView:(BdbTableView *)tableView atIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BdbCard *card = [_cards objectAtIndex:indexPath.section];
    if ([card isKindOfClass:[BdbMultiCard class]]) {
        card = [((BdbMultiCard *)card).subcards objectAtIndex:indexPath.row];
    }
    if ([self.cardDelegate respondsToSelector:@selector(didDeSelectCard:inTableView:atIndexPath:)]) {
        [self.cardDelegate didDeSelectCard:card inTableView:(BdbTableView *)tableView atIndexPath:indexPath];
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}



@end
