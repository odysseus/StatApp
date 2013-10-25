//
//  Gun.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shell.h"
#import "Module.h"

@interface Gun : Module

@property (nonatomic) NSArray *shells;
@property (nonatomic) Shell *round;
@property (nonatomic) float rateOfFire;
@property (nonatomic) float accuracy;
@property (nonatomic) float aimTime;
@property (nonatomic) float gunDepression;
@property (nonatomic) float gunElevation;


- (id)initWithDict:(NSDictionary *)dict;

- (NSString *)description;

- (void)setNormalRounds;
- (void)setGoldRounds;
- (void)setHERounds;

@end
