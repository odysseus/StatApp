//
//  Gun.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gun : NSObject

@property (nonatomic) NSString *name;
@property float weight;
@property (nonatomic) float penetration;
@property (nonatomic) float damage;
@property (nonatomic) float rateOfFire;
@property (nonatomic) float accuracy;
@property (nonatomic) float aimTime;
@property (nonatomic) BOOL stockModule;
@property (nonatomic) BOOL topModule;

@end
