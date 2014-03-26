//
//  Engine.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Engine.h"

static int engineCount = 0;

@implementation Engine

@synthesize horsepower, fireChance;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.horsepower = [[dict objectForKey:@"horsepower"] floatValue];
        self.fireChance = [[dict objectForKey:@"fireChance"] floatValue];
        
        engineCount++;
    }
    return self;
}

+ (int)count
{
    return engineCount;
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

- (id)copyWithZone:(NSZone *)zone
{
    Engine *copy = [super copyWithZone:zone];
    copy.horsepower = self.horsepower;
    copy.fireChance = self.fireChance;
    
    return copy;
}

@end













