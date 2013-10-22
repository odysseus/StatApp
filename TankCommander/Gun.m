//
//  Gun.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Gun.h"
#import "Shell.h"

@implementation Gun

@synthesize name, weight, shells, accuracy, aimTime, rateOfFire, stockModule, topModule, experienceNeeded, cost, round;

- (void)setNormalRounds
{
    round = shells[ShellTypeNormal];
}

- (void)setGoldRounds
{
    round = shells[ShellTypeGold];
}

- (void)setHERounds
{
    round = shells[ShellTypeHE];
}

@end
