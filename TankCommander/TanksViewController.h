//
//  TanksViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TankGroup, TankIPadViewController, Tank;

@interface TanksViewController : UITableViewController

@property (nonatomic) TankGroup *tankGroup;
@property (nonatomic, strong) TankIPadViewController *tankView;
@property (nonatomic, weak) Tank *compareTank;

- (id)initWithTankGroup:(TankGroup *)group;
- (id)initForCompareWithTankGroup:(TankGroup *)group andTank:(Tank *)tank;

@end
