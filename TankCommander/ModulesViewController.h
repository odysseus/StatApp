//
//  ModulesViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/18/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, TankViewController;

@interface ModulesViewController : UITableViewController

@property (nonatomic) Tank *tank;
@property (nonatomic) NSArray *moduleArray;
@property (nonatomic) TankViewController *tankViewController;

- (id)initWithTank:(Tank *)t andKey:(NSString *)key;

@end
