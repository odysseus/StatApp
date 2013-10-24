//
//  Armor.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Armor.h"

@implementation Armor

@synthesize thickness, angle;

- (id)initWithArray:(NSArray *)arr
{
    self = [super init];
    if (self) {
        self.thickness = [arr[0] floatValue];
        self.angle = [arr[1] floatValue];
    }
    return self;
}

float cosineWithDegrees(float radians)
{
    return cosf(radians * 0.0174532925);
}

- (float)effectiveThickness
{
    return (thickness / cosineWithDegrees(angle - 5));
}

@end
