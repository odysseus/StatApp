//
//  Tank.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Tank.h"
#import "Hull.h"
#import "Turret.h"
#import "Gun.h"
#import "Engine.h"
#import "Radio.h"
#import "Suspension.h"

@implementation Tank

@synthesize name, hull, turret, gun, engine, radio, suspension, availableEngines, availableGuns,
    availableRadios, availableSuspensions, availableTurrets, experienceNeeded, cost, premiumTank;

- (float)weight
{
    return (hull.weight + turret.weight + gun.weight + engine.weight + suspension.weight + radio.weight);
}

- (float)specificPower
{
    return (engine.horsepower / self.weight);
}

- (float)damagePerMinute
{
    return (gun.rateOfFire * gun.round.damage);
}

- (TankType)fetchTankType:(int)index;
{
    switch (index) {
        case 0:
            return LightTank;
        case 1:
            return MediumTank;
        case 2:
            return HeavyTank;
        case 3:
            return TankDestroyer;
        case 4:
            return SPG;
        default:
            return Vehicle;
    }
}

- (TankNationality)fetchTankNationality:(int)index;
{
    switch (index) {
        case 0:
            return American;
        case 1:
            return British;
        case 2:
            return Chinese;
        case 3:
            return French;
        case 4:
            return German;
        case 5:
            return Japanese;
        case 6:
            return Russian;
        default:
            return Nation;
    }
}

@end
