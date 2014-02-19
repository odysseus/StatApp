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
baseHitpoints, parent, child, nationality, tier, type, camoValue, averageTank, stockWeight;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // Init the main attributes
        self.name = [dict objectForKey:@"name"];
        // !!!ENUM ALERT
        self.nationality = fetchTankNationality([[dict objectForKey:@"nationality"] integerValue]);
        self.tier = [[dict objectForKey:@"tier"] integerValue];
        // !!!ENUM ALERT
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
        self.stockWeight = ([[dict objectForKey:@"stockWeight"] floatValue] * 1000);
        
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
                // Finally, add it to the module array
                [availableTurrets addObject:currentTurret];
            }
        }
        
        NSDictionary *engineValues = [dict objectForKey:@"engines"];
        availableEngines = [[NSMutableArray alloc] init];
        for (id key in engineValues) {
            Engine *currentEngine = [[Engine alloc] initWithDict:[engineValues objectForKey:key]];
            [availableEngines addObject:currentEngine];
        }
        
        NSDictionary *suspensionValues = [dict objectForKey:@"suspensions"];
        availableSuspensions = [[NSMutableArray alloc] init];
        for (id key in suspensionValues) {
            Suspension *currentSuspension = [[Suspension alloc] initWithDict:[suspensionValues objectForKey:key]];
            [availableSuspensions addObject:currentSuspension];
        }
        
        NSDictionary *radioValues = [dict objectForKey:@"radios"];
        availableRadios = [[NSMutableArray alloc] init];
        for (id key in radioValues) {
            Radio *currentRadio = [[Radio alloc] initWithDict:[radioValues objectForKey:key]];
            [availableRadios addObject:currentRadio];
        }
        
        // Finding the weight of the hull is done by taking either the stock or top weight and subtracting the weight
        // of the modules. Originally it was done using topWeight, because that saved processor cycles, but I had
        // concerns over the accuracy and availability of topWeight, so now it uses stockWeight by default, and
        // topWeight as a fallback
        if (self.stockWeight > 0) {
            [self setAllValuesStock];
            self.hull.weight = self.stockWeight - self.turret.weight - self.gun.weight -
            self.suspension.weight - self.radio.weight - self.engine.weight;
        } else {
            [self setAllValuesTop];
            self.hull.weight = self.topWeight - self.turret.weight - self.gun.weight -
            self.suspension.weight - self.radio.weight - self.engine.weight;
        }
        [self setAllValuesTop];
        [self validate];
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
                          @"speedLimit", @"camoValue", @"viewRange", @"gunDepression", @"gunElevation", nil];
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

// Setting values to stock or top
- (void)setAllValuesStock
{
    // Low hanging fruit: deal with the modules that are the same with all tanks
    for (Engine *engineMod in self.availableEngines) {
        if (engineMod.stockModule) {
            self.engine = engineMod;
        }
    }
    for (Radio *radioMod in self.availableRadios) {
        if (radioMod.stockModule) {
            self.radio = radioMod;
        }
    }
    for (Suspension *suspensionMod in self.availableSuspensions) {
        if (suspensionMod.stockModule) {
            self.suspension = suspensionMod;
        }
    }
    // Set the turret, doing it in this order allows tanks with a turret to access the right
    // array of guns, since attributes change based on the turret used
    if (self.hasTurret) {
        for (Turret *turretMod in self.availableTurrets) {
            if (turretMod.stockModule) {
                self.turret = turretMod;
            }
        }
        for (Gun *gunMod in self.turret.availableGuns) {
            if (gunMod.stockModule) {
                self.turret.gun = gunMod;
            }
        }
    } else {
        for (Gun *gunMod in self.hull.availableGuns) {
            if (gunMod.stockModule) {
                self.hull.gun = gunMod;
            }
        }
    }
}

- (void)setAllValuesTop
{
    // Low hanging fruit: deal with the modules that are the same with all tanks
    for (Engine *engineMod in self.availableEngines) {
        if (engineMod.topModule) {
            self.engine = engineMod;
        }
    }
    for (Radio *radioMod in self.availableRadios) {
        if (radioMod.topModule) {
            self.radio = radioMod;
        }
    }
    for (Suspension *suspensionMod in self.availableSuspensions) {
        if (suspensionMod.topModule) {
            self.suspension = suspensionMod;
        }
    }
    // Set the turret, doing it in this order allows tanks with a turret to access the right
    // array of guns, since attributes change based on the turret used
    if (self.hasTurret) {
        for (Turret *turretMod in self.availableTurrets) {
            if (turretMod.topModule) {
                self.turret = turretMod;
            }
        }
        for (Gun *gunMod in self.turret.availableGuns) {
            if (gunMod.topModule) {
                self.turret.gun = gunMod;
            }
        }
    } else {
        for (Gun *gunMod in self.hull.availableGuns) {
            if (gunMod.topModule) {
                self.hull.gun = gunMod;
            }
        }
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

- (float)viewRange
{
    if (self.hasTurret) {
        return self.turret.viewRange;
    } else {
        return self.hull.viewRange;
    }
}

- (float)horsepower
{
    return self.engine.horsepower;
}

- (float)fireChance
{
    return self.engine.fireChance;
}

- (float)signalRange
{
    return self.radio.signalRange;
}

// Armor Properties

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
    return self.hull.rearArmor.effectiveThickness;
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

- (int)hullTraverse
{
    return self.suspension.traverseSpeed;
}

- (int)turretTraverse
{
    if (self.hasTurret) {
        return  self.turret.traverseSpeed;
    } else {
        return self.hullTraverse;
    }
}

- (BOOL)isStock
{
    NSArray *modules = @[@"gun", @"engine", @"radio", @"suspension"];
    for (NSString *key in modules) {
        Module *mod = [self valueForKey:key];
        if (!mod.stockModule) {
            return NO;
        }
    }
    if (self.hasTurret) {
        if (!self.turret.stockModule) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isTop
{
    NSArray *modules = @[@"gun", @"engine", @"radio", @"suspension"];
    for (NSString *key in modules) {
        Module *mod = [self valueForKey:key];
        if (!mod.topModule) {
            return NO;
        }
    }
    if (self.hasTurret) {
        if (!self.turret.topModule) {
            return NO;
        }
    }
    return YES;
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

- (NSString *)stringNationality
{
    NSString *result = @"Unknown";
    switch (self.nationality) {
        case American:
            result = @"American";
            break;
        case British:
            result = @"British";
            break;
        case Chinese:
            result = @"Chinese";
            break;
        case French:
            result = @"French";
            break;
        case German:
            result = @"German";
            break;
        case Japanese:
            result = @"Japanese";
            break;
        case Russian:
            result = @"Russian";
            break;
        case Nation:
            break;
    }
    return result;
}

- (NSString *)stringNationalityAndType
{
    if (self.premiumTank) {
        return [NSString stringWithFormat:@"%@ Premium %@", self.stringNationality, self.stringTankType];
    } else {
        return [NSString stringWithFormat:@"%@ %@", self.stringNationality, self.stringTankType];
    }
}

- (NSString *)stringTankType
{
    NSString *result = @"Unknown";
    switch (self.type) {
        case LightTank:
            result = @"Light Tank";
            break;
        case MediumTank:
            result = @"Medium Tank";
            break;
        case HeavyTank:
            result = @"Heavy Tank";
            break;
        case TankDestroyer:
            result = @"Tank Destroyer";
            break;
        case SPG:
            result = @"SPG";
            break;
        case Vehicle:
            break;
    }
    return result;
}

- (UIImage *)imageForTankType
{
    switch (self.type) {
        case LightTank:
            return [UIImage imageNamed:@"lightTank"];
        case MediumTank:
            return [UIImage imageNamed:@"mediumTank"];
        case HeavyTank:
            return [UIImage imageNamed:@"heavyTank"];
        case TankDestroyer:
            return [UIImage imageNamed:@"tankDestroyer"];
        case SPG:
            return [UIImage imageNamed:@"spg"];
        default:
            return [UIImage imageNamed:@"lightTank"];
    }
}

NSString *romanStringFromInt (long convert)
{
    NSString *result = @"-";
    switch (convert) {
        case 1:
            result = @"I";
            break;
        case 2:
            result = @"II";
            break;
        case 3:
            result = @"III";
            break;
        case 4:
            result = @"IV";
            break;
        case 5:
            result = @"V";
            break;
        case 6:
            result = @"VI";
            break;
        case 7:
            result = @"VII";
            break;
        case 8:
            result = @"VIII";
            break;
        case 9:
            result = @"IX";
            break;
        case 10:
            result = @"X";
            break;
    }
    return result;
}

NSString *stringFromBool (BOOL convert)
{
    NSString *result = @"Unknown";
    if (convert) {
        result = @"True";
    } else {
        result = @"False";
    }
    return result;
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