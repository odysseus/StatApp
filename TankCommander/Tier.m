//
//  Tier.m
//  TankCommander
//
//  Created by Ryan Case on 10/22/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Tier.h"
#import "Tank.h"
#import "TankGroup.h"

@implementation Tier

@synthesize lightTanks, mediumTanks, heavyTanks, tankDestroyers, SPGs;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        lightTanks = [[TankGroup alloc] initWithDict:[dict objectForKey:@"lightTanks"]];
        mediumTanks = [[TankGroup alloc] initWithDict:[dict objectForKey:@"mediumTanks"]];
        heavyTanks = [[TankGroup alloc] initWithDict:[dict objectForKey:@"heavyTanks"]];
        tankDestroyers = [[TankGroup alloc] initWithDict:[dict objectForKey:@"tankDestroyers"]];
        SPGs = [[TankGroup alloc] initWithDict:[dict objectForKey:@"spgs"]];
    }
    return self;
}

- (int)count
{
    return ([lightTanks count] + [mediumTanks count] + [heavyTanks count] + [tankDestroyers count] + [SPGs count]);
}

- (TankGroup *)all
{
    TankGroup *allTanks = [[TankGroup alloc] init];
    for (Tank *tank in lightTanks.group) {
        [allTanks.group addObject:tank];
    }
    for (Tank *tank in mediumTanks.group) {
        [allTanks.group addObject:tank];
    }
    for (Tank *tank in heavyTanks.group) {
        [allTanks.group addObject:tank];
    }
    for (Tank *tank in tankDestroyers.group) {
        [allTanks.group addObject:tank];
    }
    for (Tank *tank in SPGs.group) {
        [allTanks.group addObject:tank];
    }
    return  allTanks;
}

- (TankGroup *)allExceptSPGs
{
    TankGroup *allExceptSPGs = [[TankGroup alloc] init];
    for (Tank *tank in lightTanks.group) {
        [allExceptSPGs.group addObject:tank];
    }
    for (Tank *tank in mediumTanks.group) {
        [allExceptSPGs.group addObject:tank];
    }
    for (Tank *tank in heavyTanks.group) {
        [allExceptSPGs.group addObject:tank];
    }
    for (Tank *tank in tankDestroyers.group) {
        [allExceptSPGs.group addObject:tank];
    }
    return  allExceptSPGs;
}

@end

















