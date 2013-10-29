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
        lightTanks = [[TankGroup alloc] init];
        NSDictionary *lightTanksData = [dict objectForKey:@"lightTanks"];
        for (id key in lightTanksData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[lightTanksData objectForKey:key]];
            [lightTanks addObject:currentTank];
        }
        
        mediumTanks = [[TankGroup alloc] init];
        NSDictionary *mediumTanksData = [dict objectForKey:@"mediumTanks"];
        for (id key in mediumTanksData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[mediumTanksData objectForKey:key]];
            [mediumTanks addObject:currentTank];
        }
        
        heavyTanks = [[TankGroup alloc] init];
        NSDictionary *heavyTanksData = [dict objectForKey:@"heavyTanks"];
        for (id key in heavyTanksData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[heavyTanksData objectForKey:key]];
            [heavyTanks addObject:currentTank];
        }
        
        tankDestroyers = [[TankGroup alloc] init];
        NSDictionary *tankDestroyersData = [dict objectForKey:@"tankDestroyers"];
        for (id key in tankDestroyersData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[tankDestroyersData objectForKey:key]];
            [tankDestroyers addObject:currentTank];
        }
        
        SPGs = [[TankGroup alloc] init];
        NSDictionary *spgsData = [dict objectForKey:@"spgs"];
        for (id key in spgsData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[spgsData objectForKey:key]];
            [SPGs addObject:currentTank];
        }
    }
    return self;
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

@end

















