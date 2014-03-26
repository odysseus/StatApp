//
//  Turret.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@class Armor, Gun;

@interface Turret : Module <NSCopying>

@property (nonatomic) float viewRange;
@property (nonatomic) float traverseSpeed;
@property (nonatomic) int additionalHP;
@property (nonatomic) Armor *frontArmor;
@property (nonatomic) Armor *sideArmor;
@property (nonatomic) Armor *rearArmor;
@property (nonatomic) NSMutableArray *availableGuns;
@property (nonatomic) Gun *gun;

- (id)initWithDict:(NSDictionary *)dict;

- (NSString *)description;
+ (int)count;

@end
