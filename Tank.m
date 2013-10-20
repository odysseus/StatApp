//
//  Tank.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Tank.h"

@implementation Tank

@synthesize armorAngle, armorThickness;

float degCos(float radians)
{
    return cosf(radians * 0.0174532925);
}

- (float)normalizedEffectiveArmor
{
    return (armorThickness / degCos(armorAngle - 5));
}

@end
