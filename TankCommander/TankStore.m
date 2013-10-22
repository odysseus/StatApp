//
//  TankStore.m
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankStore.h"

static TankStore *allTanks = nil;

@implementation TankStore

+ (TankStore *)allTanks
{
    if (!allTanks)
        allTanks = [[super allocWithZone:nil] init];
    return allTanks;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self allTanks];
}

@end
