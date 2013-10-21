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
    LightTank,
    MediumTank,
    HeavyTank,
    TankDestroyer,
    SPG
} TankType;

// The tank name, type and tier
@property (nonatomic) NSString *name;
@property (nonatomic) int tier;
@property (nonatomic) TankType *type;

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
