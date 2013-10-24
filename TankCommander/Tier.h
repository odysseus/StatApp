//
//  Tier.h
//  TankCommander
//
//  Created by Ryan Case on 10/22/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tier : NSObject

@property (nonatomic) NSMutableArray *lightTanks;
@property (nonatomic) NSMutableArray *mediumTanks;
@property (nonatomic) NSMutableArray *heavyTanks;
@property (nonatomic) NSMutableArray *tankDestroyers;
@property (nonatomic) NSMutableArray *SPGs;

- (id)initWithDict:(NSDictionary *)dict;

@end
