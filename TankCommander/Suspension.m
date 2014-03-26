//
//  Suspension.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Suspension.h"

static int suspensionCount = 0;

@implementation Suspension

@synthesize loadLimit, traverseSpeed, hardTerrainResistance, mediumTerrainResistance, softTerrainResistance;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.loadLimit = [[dict objectForKey:@"loadLimit"] floatValue];
        self.traverseSpeed = [[dict objectForKey:@"traverseSpeed"] floatValue];
        NSArray *terrainResistance = [dict objectForKey:@"terrainResistance"];
        self.hardTerrainResistance = [terrainResistance[0] floatValue];
        self.mediumTerrainResistance = [terrainResistance[1] floatValue];
        self.softTerrainResistance = [terrainResistance[2] floatValue];
        
        suspensionCount++;
    }
    return self;
}

+ (int)count
{
    return suspensionCount;
}

- (NSString *)description
{
    return self.name;
}

- (NSString *)stringSummary
{
    return [NSString stringWithFormat:@"Load Limit: %0.2f",
            self.loadLimit];
}

- (id)copyWithZone:(NSZone *)zone
{
    Suspension *copy = [super copyWithZone:zone];
    NSArray *primitives = @[@"loadLimit", @"traverseSpeed", @"hardTerrainResistance", @"mediumTerrainResistance", @"softTerrainResistance"];
    for (NSString *key in primitives) {
        [copy setValue:[self valueForKey:key] forKey:key];
    }
    return copy;
}

@end












