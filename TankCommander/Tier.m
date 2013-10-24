//
//  Tier.m
//  TankCommander
//
//  Created by Ryan Case on 10/22/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Tier.h"
#import "Tank.h"

@implementation Tier

@synthesize lightTanks, mediumTanks, heavyTanks, tankDestroyers, SPGs;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        lightTanks = [[NSMutableArray alloc] init];
        NSDictionary *lightTanksData = [dict objectForKey:@"lightTanks"];
        for (id key in lightTanksData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[lightTanksData objectForKey:key]];
            [lightTanks addObject:currentTank];
        }
        
        mediumTanks = [[NSMutableArray alloc] init];
        NSDictionary *mediumTanksData = [dict objectForKey:@"mediumTanks"];
        for (id key in mediumTanksData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[mediumTanksData objectForKey:key]];
            [mediumTanks addObject:currentTank];
        }
        
        heavyTanks = [[NSMutableArray alloc] init];
        NSDictionary *heavyTanksData = [dict objectForKey:@"heavyTanks"];
        for (id key in heavyTanksData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[heavyTanksData objectForKey:key]];
            [heavyTanks addObject:currentTank];
        }
        
        tankDestroyers = [[NSMutableArray alloc] init];
        NSDictionary *tankDestroyersData = [dict objectForKey:@"tankDestroyers"];
        for (id key in tankDestroyersData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[tankDestroyersData objectForKey:key]];
            [tankDestroyers addObject:currentTank];
        }
        
        SPGs = [[NSMutableArray alloc] init];
        NSDictionary *spgsData = [dict objectForKey:@"spgs"];
        for (id key in spgsData) {
            Tank *currentTank = [[Tank alloc] initWithDict:[spgsData objectForKey:key]];
            [SPGs addObject:currentTank];
        }
    }
    return self;
}

@end
