//
//  Suspension.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@interface Suspension : Module

@property (nonatomic) float loadLimit;
@property (nonatomic) int traverseSpeed;
@property (nonatomic) float hardTerrainResistance;
@property (nonatomic) float mediumTerrainResistance;
@property (nonatomic) float softTerrainResistance;

- (id)initWithDict:(NSDictionary *)dict;

- (NSString *)description;
+ (int)count;

@end
