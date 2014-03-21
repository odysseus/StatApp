//
//  TankComparisonTableViewController.h
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, RCFormatting;

@interface TankComparisonTableViewController : UITableViewController

// The tanks
@property (nonatomic, weak) Tank *tankOne;
@property (nonatomic, weak) Tank *tankTwo;

// The keys
@property (nonatomic) NSDictionary *compareDict;
@property (nonatomic) NSArray *moduleKeys;
@property (nonatomic) NSArray *tankOneKeys;
@property (nonatomic) NSArray *tankTwoKeys;

// The singletons with useful things
@property (nonatomic) RCFormatting *format;

// The tankViewController for the first tank
@property (nonatomic, weak) UIViewController *tankViewController;

- (id)initWithTankOne:(Tank *)t1 andTwo:(Tank *)t2;
- (void)popToTankViewController;
- (UIView *)tableHeaderView;

@end
