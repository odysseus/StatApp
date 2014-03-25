//
//  TankIPhoneViewController.h
//  TankCommander
//
//  Created by Ryan Case on 3/6/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, RCButton, RCFormatting;

@interface TankIPhoneViewController : UITableViewController

@property (nonatomic, weak) Tank *tank;
@property (nonatomic) NSArray *turretedIndex;
@property (nonatomic) NSArray *nonTurretedIndex;
@property (nonatomic) RCFormatting *format;
@property (nonatomic) BOOL compare;

- (UIView *)tableHeaderView;
- (void)pushModulesViewController:(RCButton *)sender;
- (void)tankCompare;

@end
