//
//  HomePageTableViewController.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "HomeGoodsCell.h"


@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
# warning Test Example
    NSMutableArray *array = [NSMutableArray array];
    BdbMultiCard *card = [[BdbMultiCard alloc] init];
    
    BdbCard *card1 = [[BdbCard alloc] init];
    card1.cardClassID = @"HomeGoodsCell";
    card1.cardHeight = 100;
    [card.subcards addObject:card1];
    
    [array addObject:card];
    self.cards = array;
}


@end
