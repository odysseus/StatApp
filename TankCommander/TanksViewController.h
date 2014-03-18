//
//  TanksViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TankGroup, Tank;

@interface TanksViewController : UITableViewController

@property (nonatomic) TankGroup *tankGroup;
@property (nonatomic, weak) Tank *compareTank;
@property (nonatomic, weak) UIViewController *tankViewController;


- (id)initWithTankGroup:(TankGroup *)group;
- (id)initForCompareWithTankGroup:(TankGroup *)group andTank:(Tank *)tank;

@end
