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

@synthesize name, hull, turret, engine, radio, suspension, availableEngines, availableRadios, topWeight, hasTurret,
    availableSuspensions, availableTurrets, experienceNeeded, cost, premiumTank, gunTraverseArc, crewLevel;


- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // Init the main attributes
        self.name = [dict objectForKey:@"name"];
        self.nationality = fetchTankNationality([[dict objectForKey:@"nationality"] integerValue]);
        self.tier = [[dict objectForKey:@"tier"] integerValue];
        self.type = fetchTankType([[dict objectForKey:@"type"] integerValue]);
        self.premiumTank = [[dict objectForKey:@"premiumTank"] boolValue];
        self.hasTurret = [[dict objectForKey:@"turreted"] boolValue];
        self.experienceNeeded = [[dict objectForKey:@"experienceNeeded"] integerValue];
        self.cost = [[dict objectForKey:@"cost"] integerValue];
        self.baseHitpoints = [[dict objectForKey:@"baseHitpoints"] integerValue];
        self.gunTraverseArc = [[dict objectForKey:@"gunArc"] floatValue];
        self.crewLevel = [[dict objectForKey:@"crewLevel"] floatValue];
        self.topWeight = ([[dict objectForKey:@"topWeight"] floatValue] * 1000);
                
        if (![dict objectForKey:@"premiumTank"]) {
            self.parent = [dict objectForKey:@"parent"];
            self.child = [dict objectForKey:@"child"];
        }
        
        // Add the hull - init will be different depending on whether the gun is in the turret or the hull
        self.hull = [[Hull alloc] initWithDict:[dict objectForKey:@"hull"] forTurreted:hasTurret];
        
        if ([dict objectForKey:@"turrets"]) {
            // Each of the following chunks for the module groups is functionally the same
            // First fetch the JSON for the module group
            NSDictionary *turretValues = [dict objectForKey:@"turrets"];
            // Init the NSMutableArray to hold the objects
            availableTurrets = [[NSMutableArray alloc] init];
            // Init each object from the JSON
            for (id key in turretValues) {
                Turret *currentTurret = [[Turret alloc] initWithDict:[turretValues objectForKey:key]];
                // If the module is the top module, set it to the selected
                // module so the top modules are the default
                if (currentTurret.topModule) {
                    self.turret = currentTurret;
                }
                // Finally, add it to the module array
                [availableTurrets addObject:currentTurret];
            }
        }
        
        NSDictionary *engineValues = [dict objectForKey:@"engines"];
        availableEngines = [[NSMutableArray alloc] init];
        for (id key in engineValues) {
            Engine *currentEngine = [[Engine alloc] initWithDict:[engineValues objectForKey:key]];
            if (currentEngine.topModule) {
                self.engine = currentEngine;
            }
            [availableEngines addObject:currentEngine];
        }
        
        NSDictionary *suspensionValues = [dict objectForKey:@"suspensions"];
        availableSuspensions = [[NSMutableArray alloc] init];
        for (id key in suspensionValues) {
            Suspension *currentSuspension = [[Suspension alloc] initWithDict:[suspensionValues objectForKey:key]];
            if (currentSuspension.topModule) {
                self.suspension = currentSuspension;
            }
            [availableSuspensions addObject:currentSuspension];
        }
        
        NSDictionary *radioValues = [dict objectForKey:@"radios"];
        availableRadios = [[NSMutableArray alloc] init];
        for (id key in radioValues) {
            Radio *currentRadio = [[Radio alloc] initWithDict:[radioValues objectForKey:key]];
            if (currentRadio.topModule) {
                self.radio = currentRadio;
            }
            [availableRadios addObject:currentRadio];
        }
        // Finding the hull weight is a pain since it's not really available anywhere, so the variable topWeight holds
        // the weight with all the top modules, since the top modules are automatically equipped we can subtract the
        // weight of the individual modules from the top weight to get the hull weight
        self.hull.weight = self.topWeight - self.turret.weight - self.gun.weight -
            self.suspension.weight - self.radio.weight - self.engine.weight;
    }
    return self;
}

- (NSString *)description
{
    if (self.premiumTank) {
        return [NSString stringWithFormat:@"*%@", name];
    } else {
        return name;
    }
}

// Pass through properties

- (Gun *)gun
{
    if (hasTurret) {
        return turret.gun;
    } else {
        return hull.gun;
    }
}

- (float)penetration
{
    return self.gun.round.penetration;
}

- (float)aimTime
{
    return self.gun.aimTime;
}

- (float)accuracy
{
    return self.gun.accuracy;
}

- (float)rateOfFire
{
    return self.gun.rateOfFire;
}

- (float)gunDepression
{
    return self.gun.gunDepression;
}

- (float)gunElevation
{
    return self.gun.gunElevation;
}

- (float)alphaDamage
{
    return self.gun.round.damage;
}

- (BOOL)autoloader
{
    return self.gun.autoloader;
}

- (float)roundsInDrum
{
    if (self.autoloader) {
        return self.gun.roundsInDrum;
    } else {
        return 1.0;
    }
}

- (float)drumReload
{
    if (self.autoloader) {
        return self.gun.drumReload;
    } else {
        return self.reloadTime;
    }
}

- (float)timeBetweenShots
{
    if (self.autoloader) {
        return self.gun.timeBetweenShots;
    } else {
        return self.reloadTime;
    }
}

- (int)hitpoints
{
    if (self.hasTurret) {
        return self.baseHitpoints + turret.additionalHP;
    } else {
        return self.baseHitpoints;
    }
}

- (float)weight
{
    return (hull.weight + turret.weight + self.gun.weight + engine.weight + suspension.weight + radio.weight) / 1000.0;
}

- (float)specificPower
{
    return (engine.horsepower / self.weight);
}

- (float)damagePerMinute
{
    return (self.gun.rateOfFire * self.gun.round.damage);
}

- (float)reloadTime
{
    return 60.0 / self.gun.rateOfFire;
}

TankType fetchTankType (int index)
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

TankNationality fetchTankNationality (int index)
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
    
- (BOOL)isTopTurretNeededForTopGun
{
    if (self.hasTurret) {
        Turret *stock = self.availableTurrets[0];
        Turret *top = self.availableTurrets[1];
        if (stock.gun.name == top.gun.name) {
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}


@end
