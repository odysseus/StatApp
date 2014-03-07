//
//  ModulesViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/18/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, TankIPadViewController, TankIPhoneViewController;

@interface ModulesViewController : UITableViewController

@property (nonatomic) Tank *tank;
@property (nonatomic) NSArray *moduleArray;
@property (nonatomic) TankIPadViewController *tankIPadViewController;
@property (nonatomic) TankIPhoneViewController *tankIPhoneViewController;

- (id)initWithTank:(Tank *)t andKey:(NSString *)key;

@end
