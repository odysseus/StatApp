//
//  TypesViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/16/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tier;

@interface TypesViewController : UITableViewController

@property (nonatomic) NSArray *keys;
@property (nonatomic) Tier *tier;

- (id)initWithTier:(Tier *)tier;

@end
