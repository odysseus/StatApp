//
//  Module.m
//  TankCommander
//
//  Created by Ryan Case on 10/23/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Module.h"

@implementation Module

@synthesize name, weight, stockModule, topModule, experienceNeeded, cost;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.tier = [[dict objectForKey:@"tier"] integerValue];
        self.weight = [[dict objectForKey:@"weight"] floatValue];
        self.stockModule = [[dict objectForKey:@"stockModule"] boolValue];
        self.topModule = [[dict objectForKey:@"topModule"] boolValue];
        self.experienceNeeded = [[dict objectForKey:@"experienceNeeded"] integerValue];
        self.cost = [[dict objectForKey:@"cost"] integerValue];
    }
    return self;
}

- (NSString *)description
{
    return name;
}

- (NSString *)stringSummary
{
    return [NSString stringWithFormat:@"%@: %d", self.name, self.tier];
}

@end
