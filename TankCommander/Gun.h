//
//  Gun.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shell.h"

@interface Gun : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) NSArray *shells;
@property (nonatomic) float rateOfFire;
@property (nonatomic) float accuracy;
@property (nonatomic) float aimTime;

@property float weight;
@property (nonatomic) BOOL stockModule;
@property (nonatomic) BOOL topModule;
@property (nonatomic) int experienceNeeded;
@property (nonatomic) int cost;

- (Shell *)selectedShell:(ShellType)type;

@end
