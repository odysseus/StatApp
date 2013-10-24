//
//  Turret.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@class Armor;

@interface Turret : Module

@property (nonatomic) float viewRange;
@property (nonatomic) float traverseSpeed;
@property (nonatomic) int additionalHP;
@property (nonatomic) Armor *frontArmor;
@property (nonatomic) Armor *sideArmor;
@property (nonatomic) Armor *rearArmor;


- (id)initWithDict:(NSDictionary *)dict;


@end
