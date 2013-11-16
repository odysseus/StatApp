//
//  Tier.h
//  TankCommander
//
//  Created by Ryan Case on 10/22/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TankGroup;

@interface Tier : NSObject

@property (nonatomic) TankGroup *lightTanks;
@property (nonatomic) TankGroup *mediumTanks;
@property (nonatomic) TankGroup *heavyTanks;
@property (nonatomic) TankGroup *tankDestroyers;
@property (nonatomic) TankGroup *SPGs;

- (int)count;
- (NSArray *)fetchValidKeys;

- (TankGroup *)all;
- (TankGroup *)allExceptSPGs;

- (id)initWithDict:(NSDictionary *)dict;

@end
