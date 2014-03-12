//
//  Turret.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Turret.h"
#import "Armor.h"
#import "Gun.h"

@implementation Turret

@synthesize viewRange, traverseSpeed, frontArmor, sideArmor, rearArmor, additionalHP, availableGuns, gun;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.viewRange = [[dict objectForKey:@"viewRange"] floatValue];
        self.traverseSpeed = [[dict objectForKey:@"traverseSpeed"] floatValue];
        self.additionalHP = [[dict objectForKey:@"additionalHP"] intValue];
        self.frontArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"frontArmor"]];
        self.sideArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"sideArmor"]];
        self.rearArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"rearArmor"]];
        
        availableGuns = [[NSMutableArray alloc] init];
        NSDictionary *gunValues = [dict objectForKey:@"availableGuns"];
        for (id key in gunValues) {
            NSDictionary *gunDict = [gunValues objectForKey:key];
            Gun *currentGun = [[Gun alloc] initWithDict: gunDict];
            [availableGuns addObject:currentGun];
            if (currentGun.topModule) {
                self.gun = currentGun;
            }
        }
    }
    return self;
}

- (NSString *)description
{
    return self.name;
}

- (NSString *)stringSummary
{
    if (self.stockModule) {
        return @"Stock Turret";
    } else {
        return @"Top Turret";
    }
}

@end
