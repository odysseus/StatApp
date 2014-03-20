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

@synthesize shells, round, rateOfFire, accuracy, aimTime, roundsInDrum, drumReload, timeBetweenShots,
normalRound, heRound, goldRound;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        // Init the shells
        NSArray *shellValues = [dict objectForKey:@"shells"];
        NSMutableArray *shellsArr = [[NSMutableArray alloc] init];
        for (NSArray *shellArray in shellValues) {
            Shell *s = [[Shell alloc] initWithArr:shellArray];
            // Set the gun properties for each shell based on shell type
            if (s.shellType == ShellTypeNormal) {
                self.normalRound = s;
            } else if (s.shellType == ShellTypeGold) {
                self.goldRound = s;
            } else if (s.shellType == ShellTypeHE) {
                self.heRound = s;
            }
            [shellsArr addObject:s];
        }
        NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"shellType" ascending:YES];
        [shellsArr sortedArrayUsingDescriptors:@[sortDesc]];
        self.shells = shellsArr;
        
        // Init the rest of the gun values
        self.rateOfFire = [[dict objectForKey:@"rateOfFire"] floatValue];
        self.accuracy = [[dict objectForKey:@"accuracy"] floatValue];
        self.aimTime = [[dict objectForKey:@"aimTime"] floatValue];
        self.gunDepression = [[dict objectForKey:@"gunDepression"] floatValue];
        self.gunElevation = [[dict objectForKey:@"gunElevation"] floatValue];
        self.autoloader = [[dict objectForKey:@"autoloader"] boolValue];
        if (self.autoloader) {
            self.roundsInDrum = [[dict objectForKey:@"roundsInDrum"] floatValue];
            self.drumReload = [[dict objectForKey:@"drumReload"] floatValue];
            self.timeBetweenShots = [[dict objectForKey:@"timeBetweenShots"] floatValue];
        }
        self.round = self.shells[0];
    }
    return self;
}

- (NSArray *)stringShellArray
{
    NSMutableArray *final = [[NSMutableArray alloc] init];
    for (Shell *shell in self.shells) {
        [final addObject:[shell description]];
    }
    return final;
}

- (NSArray *)shellTypeArray
{
    NSMutableArray *final = [[NSMutableArray alloc] init];
    for (Shell *shell in self.shells) {
        [final addObject:shell];
    }
    return final;
}

- (NSString *)description
{
    return self.name;
}

- (NSString *)stringSummary
{
    return [NSString stringWithFormat:@"Pen: %0.0f - Dmg: %0.0f - ROF: %0.2f",
            self.round.penetration, self.round.damage, self.rateOfFire];
}

- (void)setNormalRounds
{
    round = self.normalRound;
}

- (void)setGoldRounds
{
    if (self.goldRound) {
        round = self.goldRound;
    }
}

- (void)setHERounds
{
    if (self.heRound) {
        round = self.heRound;
    }
}

- (float)burstDamage
{
    if (self.roundsInDrum) {
        return self.roundsInDrum * self.round.damage;
    } else {
        return self.round.damage;
    }
}

- (float)burstLength
{
    if (self.roundsInDrum) {
        return self.roundsInDrum * self.timeBetweenShots;
    } else {
        return 1;
    }
}

@end
