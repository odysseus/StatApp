//
//  Turret.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Armor;

@interface Turret : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) float viewRange;
@property (nonatomic) float traverseSpeed;
@property (nonatomic) Armor *frontArmor;
@property (nonatomic) Armor *sideArmor;
@property (nonatomic) Armor *rearArmor;

@property (nonatomic) float weight;
@property (nonatomic) BOOL stockModule;
@property (nonatomic) BOOL topModule;
@property (nonatomic) int experienceNeeded;
@property (nonatomic) int cost;

@end
