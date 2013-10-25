//
//  Tank.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Hull, Turret, Gun, Engine, Radio, Suspension;

@interface Tank : NSObject

typedef enum TankType : NSUInteger {
    LightTank,      // 0
    MediumTank,     // 1
    HeavyTank,      // 2
    TankDestroyer,  // 3
    SPG,            // 4
    Vehicle         // 5
} TankType;

typedef enum TankNationality : NSUInteger {
    American,       // 0
    British,        // 1
    Chinese,        // 2
    French,         // 3
    German,         // 4
    Japanese,       // 5
    Russian,        // 6
    Nation          // 7
} TankNationality;

// The tank name, type and tier
@property (nonatomic) NSString *name;
@property (nonatomic) TankNationality nationality;
@property (nonatomic) int tier;
@property (nonatomic) TankType type;
@property (nonatomic) BOOL premiumTank;
@property (nonatomic) int experienceNeeded;
@property (nonatomic) int cost;
@property (nonatomic) int baseHitpoints;
@property (nonatomic) float gunTraverseArc;

// These arrays hold the equippable modules
@property (nonatomic) NSMutableArray *availableTurrets;
@property (nonatomic) NSMutableArray *availableEngines;
@property (nonatomic) NSMutableArray *availableSuspensions;
@property (nonatomic) NSMutableArray *availableRadios;

// The modules that are currently equipped will be stored in these variables
@property (nonatomic) Hull *hull;
@property (nonatomic) Turret *turret;
@property (nonatomic) Engine *engine;
@property (nonatomic) Radio *radio;
@property (nonatomic) Suspension *suspension;

- (id)initWithDict:(NSDictionary *)dict;

- (NSString *)description;

- (float)weight;
- (float)specificPower;
- (float)damagePerMinute;
- (Gun *)gun;

TankNationality fetchTankNationality (int index);
TankType fetchTankType (int index);


@end
