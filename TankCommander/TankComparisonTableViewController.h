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

@property (nonatomic, weak) Tank *tankOne;
@property (nonatomic, weak) Tank *tankTwo;
@property (nonatomic) NSDictionary *keyHash;
@property (nonatomic) NSArray *keyIndex;
@property (nonatomic) RCFormatting *format;
@property (nonatomic) RCToolTips *tooltips;

- (id)initWithTankOne:(Tank *)t1 andTwo:(Tank *)t2;

@end
