//
//  Engine.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Engine.h"

@implementation Engine

@synthesize horsepower, fireChance;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.horsepower = [[dict objectForKey:@"horsepower"] floatValue];
        self.fireChance = [[dict objectForKey:@"fireChance"] floatValue];
    }
    return self;
}

- (NSString *)description;
{
    return self.name;
}

- (NSString *)stringSummary
{
    return [NSString stringWithFormat:@"Horsepower: %0.0f",
            self.horsepower];
}

@end
