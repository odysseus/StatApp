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
#import "Armor.h"

@implementation Tank

@synthesize name, hull, turret, engine, radio, suspension, availableEngines, availableRadios, topWeight, hasTurret,
    availableSuspensions, availableTurrets, experienceNeeded, cost, premiumTank, gunTraverseArc, crewLevel, speedLimit,
    baseHitpoints, parent, child, nationality, tier, type, camoValue;

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
        self.speedLimit = [[dict objectForKey:@"speedLimit"] floatValue];
        self.camoValue = [[dict objectForKey:@"camoValue"] floatValue];
        self.crewLevel = [[dict objectForKey:@"crewLevel"] floatValue];
        self.topWeight = ([[dict objectForKey:@"topWeight"] floatValue] * 1000);
                
        if (!self.premiumTank) {
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

- (BOOL)validate
{
    BOOL result = YES;
    // The validation is being separated into categories, the first is floatKeys,
    // which require both non-null and nonzero values
    NSArray *floatKeys = [NSArray arrayWithObjects:
                          @"tier", @"cost", @"crewLevel", @"baseHitpoints", @"topWeight", @"gunTraverseArc",
                          @"speedLimit", @"camoValue", nil];
    for (NSString *key in floatKeys) {
        if ([[self valueForKey:key] floatValue] == 0.0) {
            NSLog(@"%@ is missing %@", self.name, key);
            result = NO;
        }
    }
    // These keys check only for the presence of a value
    NSArray *presenceKeys = [NSArray arrayWithObjects:
                             @"name", @"nationality", @"type", @"hasTurret", @"premiumTank", @"experienceNeeded",
                             @"hull", @"engine", @"radio", @"suspension", nil];
    for (NSString *key in presenceKeys) {
        if (![self valueForKey:key]) {
            NSLog(@"%@ is missing %@", self.name, key);
            result = NO;
        }
    }
    // Some validations are not needed if the tank is a premium
    if (!self.premiumTank) {
        if (self.experienceNeeded < 1) {
            NSLog(@"Non-premium tank %@ is missing experience needed",
                  self.name);
            result = NO;
        }
        if (!self.parent | !self.child) {
            NSLog(@"%@ is missing parent and/or child: parent: %@, child: %@", self.name, self.parent, self.child);
            result = NO;
        }
    }
    // Finally, validate the module arrays to ensure there is only one stock and one top module for each
    NSMutableArray *moduleArrayKeys = [NSMutableArray arrayWithObjects:
                                @"availableEngines", @"availableSuspensions", @"availableRadios", @"availableGuns",
                                       nil];
    if (self.hasTurret) {
        [moduleArrayKeys addObject:@"availableTurrets"];
    }
    
    for (NSString *key in moduleArrayKeys) {
        result = [self validateModuleArray:key];
    }
    
    
    return result;
}

- (BOOL)validateModuleArray:(NSString *)moduleArrayString
{
    BOOL result = YES;
    NSArray *moduleArray = [self valueForKey:moduleArrayString];
    int stockValues = 0;
    int topValues = 0;
    // There can only be one stock module and one top module for each module type,
    // this method checks to ensure that this is true
    for (Module *mod in moduleArray) {
        // First we count the number of modules labelled stock and top
        if (mod.topModule) {
            topValues++;
        }
        if (mod.stockModule) {
            stockValues++;
        }
    }
    // Then log errors accordingly and change the bool value
    if (topValues == 0) {
        NSLog(@"Error: %@ %@ is missing a top module",
              self.name, moduleArrayString);
        result = NO;
    } else if (topValues > 1) {
        NSLog(@"Error: %@ %@ has too many top modules",
              self.name, moduleArrayString);
        result = NO;
    }
    // The method will fail if any of the four conditions are wrong, so the log statements
    // can stay in here permanently to specify the error
    if (stockValues == 0) {
        NSLog(@"Error: %@ %@ is missing a stock module",
              self.name, moduleArrayString);
        result = NO;
    } else if (stockValues > 1) {
        NSLog(@"Error: %@ %@ has too many stock modules",
              self.name, moduleArrayString);
        result = NO;
    }
    return result;
}

- (NSString *)description
{
    if (self.premiumTank) {
        return [NSString stringWithFormat:@"*%@", name];
    } else {
        return name;
    }
}

- (float)calculateProgressiveStatWithNominalStat:(float)nominalStat
                             effectiveSkillLevel:(float)effectiveSkillLevel
                               andEquipmentBonus:(float)equipmentBonus
{
    return ((nominalStat / 0.875) * ((0.00375 * effectiveSkillLevel + 0.5) + equipmentBonus));
}

- (float)calculateDegressiveStatWithNominalStat:(float)nominalStat
                            effectiveSkillLevel:(float)effectiveSkillLevel
                              andEquipmentBonus:(float)equipmentBonus
{
    return ((nominalStat * 0.875) / (0.00375 * effectiveSkillLevel + 0.5)) + equipmentBonus;
}

- (float)skillLevel
{
    return (self.crewLevel * 1.1);
}

- (float)skillLevelVentAndBIA
{
    return ((self.crewLevel + 10.0) * 1.1);
}

- (float)topRateOfFire
{
    return [self calculateProgressiveStatWithNominalStat:self.rateOfFire
                                     effectiveSkillLevel:self.skillLevelVentAndBIA
                                       andEquipmentBonus:0.10];
}

- (float)fastestReload
{
    return 60.0 / self.topRateOfFire;
}

- (float)fastestAimTime
{
    return [self calculateDegressiveStatWithNominalStat:self.aimTime
                                    effectiveSkillLevel:self.skillLevel
                                      andEquipmentBonus:0.0];
}

// Pass through properties

- (NSArray *)availableGuns
{
    if (self.hasTurret) {
        return self.turret.availableGuns;
    } else {
        return self.hull.availableGuns;
    }
}

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

- (float)loadLimit
{
    return self.suspension.loadLimit;
}

- (float)frontalHullArmor
{
    return self.hull.frontArmor.thickness;
}

- (float)sideHullArmor
{
    return self.hull.sideArmor.thickness;
}

- (float)rearHullArmor
{
    return self.hull.rearArmor.thickness;
}

- (float)effectiveFrontalHullArmor
{
    return self.hull.frontArmor.effectiveThickness;
}

- (float)effectiveSideHullArmor
{
    return self.hull.sideArmor.effectiveThickness;
}

- (float)effectiveRearHullArmor
{
    return self.hull.rearArmor.thickness;
}

- (float)frontalTurretArmor
{
    if (self.hasTurret) {
        return self.turret.frontArmor.thickness;
    } else {
        return self.frontalHullArmor;
    }
}

- (float)sideTurretArmor
{
    if (self.hasTurret) {
        return self.turret.sideArmor.thickness;
    } else {
        return self.sideHullArmor;
    }
}

- (float)rearTurretArmor
{
    if (self.hasTurret) {
        return self.turret.rearArmor.thickness;
    } else {
        return self.rearHullArmor;
    }
}

- (float)effectiveFrontalTurretArmor
{
    if (self.hasTurret) {
        return self.turret.frontArmor.effectiveThickness;
    } else {
        return self.effectiveFrontalHullArmor;
    }
}

- (float)effectiveSideTurretArmor
{
    if (self.hasTurret) {
        return self.turret.sideArmor.effectiveThickness;
    } else {
        return self.effectiveSideHullArmor;
    }
}

- (float)effectiveRearTurretArmor
{
    if (self.hasTurret) {
        return self.turret.rearArmor.effectiveThickness;
    } else {
        return self.effectiveRearHullArmor;
    }
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

- (int)totalExperienceNeeded
{
    int totalExp = 0;
    NSArray *modules = [[NSArray alloc] init];
    if (self.hasTurret) {
        modules = [NSArray arrayWithObjects:
                            @"availableTurrets", @"availableGuns", @"availableSuspensions", @"availableEngines",
                            @"availableRadios", nil];
    } else {
        modules = [NSArray arrayWithObjects:
                            @"availableGuns", @"availableSuspensions", @"availableEngines", @"availableRadios", nil];
    }
    for (NSString *key in modules) {
        NSArray *moduleArray = [self valueForKey:key];
        for (Module *mod in moduleArray) {
            totalExp += mod.experienceNeeded;
        }
    }
    return totalExp;
}

@end