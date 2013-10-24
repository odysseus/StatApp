//
//  Turret.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Turret.h"
#import "Armor.h"

@implementation Turret

@synthesize viewRange, traverseSpeed, frontArmor, sideArmor, rearArmor, additionalHP;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.viewRange = [[dict objectForKey:@"viewRange"] floatValue];
        self.traverseSpeed = [[dict objectForKey:@"traverseSpeed"] floatValue];
        self.additionalHP = [[dict objectForKey:@"additionalHP"] integerValue];
        self.frontArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"frontArmor"]];
        self.sideArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"sideArmor"]];
        self.rearArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"rearArmor"]];
    }
    return self;
}

@end
