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

typedef enum {
    LightTank,      // 0
    MediumTank,     // 1
    HeavyTank,      // 2
    TankDestroyer,  // 3
    SPG             // 4
} TankType;

typedef enum {
    American,   // 0
    British,    // 1
    Chinese,    // 2
    French,     // 3
    German,     // 4
    Japanese,   // 5
    Russian     // 6
} TankNationality;

// The tank name, type and tier
@property (nonatomic) NSString *name;
@property (nonatomic) TankNationality *nationality;
@property (nonatomic) int tier;
@property (nonatomic) TankType *type;
@property (nonatomic) BOOL premiumTank;
@property (nonatomic) int experienceNeeded;
@property (nonatomic) int cost;

// These arrays hold the equippable modules
@property (nonatomic) NSArray *availableTurrets;
@property (nonatomic) NSArray *availableGuns;
@property (nonatomic) NSArray *availableEngines;
@property (nonatomic) NSArray *availableRadios;
@property (nonatomic) NSArray *availableSuspensions;

// The modules that are actually equipped will be stored in these variables
@property (nonatomic) Hull *hull;
@property (nonatomic) Turret *turret;
@property (nonatomic) Gun *gun;
@property (nonatomic) Engine *engine;
@property (nonatomic) Radio *radio;
@property (nonatomic) Suspension *suspension;


@end
