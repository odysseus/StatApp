//
//  Tier.h
//  TankCommander
//
//  Created by Ryan Case on 10/22/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tier : NSObject

@property (nonatomic) NSDictionary *lightTanks;
@property (nonatomic) NSDictionary *mediumTanks;
@property (nonatomic) NSDictionary *heavyTanks;
@property (nonatomic) NSDictionary *tankDestroyers;
@property (nonatomic) NSDictionary *SPGs;

@end
