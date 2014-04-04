//
//  TiersViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/16/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TankStore, Tank;

@interface TiersViewController : UITableViewController

@property (nonatomic) NSArray *keys;
@property (nonatomic) NSArray *keyStrings;
@property (nonatomic) TankStore *allTanks;
@property (nonatomic, weak) Tank *compareTank;
@property (nonatomic, weak) UIViewController *tankViewController;

- (id)initForCompareWithTank:(Tank *)t;
- (UIView *)footerView;
- (void)presentHelpView;

@end
