//
//  Hull.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Hull.h"
#import "Armor.h"

@implementation Hull

@synthesize weight, frontArmor, sideArmor, rearArmor;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.weight = [[dict objectForKey:@"weight"] floatValue];
        self.frontArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"frontArmor"]];
        self.sideArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"sideArmor"]];
        self.rearArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"rearArmor"]];
    }
    return self;
}


@end
