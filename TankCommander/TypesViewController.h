//
//  TypesViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/16/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tier, Tank;

@interface TypesViewController : UITableViewController

@property (nonatomic) NSArray *keys;
@property (nonatomic) Tier *tier;
@property (nonatomic, weak) Tank *compareTank;
@property (nonatomic, weak) UIViewController *tankViewController;


- (id)initWithTier:(Tier *)t;
- (id)initForCompareWithTier:(Tier *)t andTank:(Tank *)tank;
- (void)popToRootVC;

@end
