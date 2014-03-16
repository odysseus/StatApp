//
//  TankComparisonTableViewController.h
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, RCFormatting, RCToolTips;

@interface TankComparisonTableViewController : UITableViewController

// The tanks
@property (nonatomic, weak) Tank *tankOne;
@property (nonatomic, weak) Tank *tankTwo;

// The keys
@property (nonatomic) NSArray *combinedKeys;
@property (nonatomic) NSArray *tankOneKeys;
@property (nonatomic) NSArray *tankTwoKeys;

// The singletons with useful things
@property (nonatomic) RCFormatting *format;

- (id)initWithTankOne:(Tank *)t1 andTwo:(Tank *)t2;

@end
