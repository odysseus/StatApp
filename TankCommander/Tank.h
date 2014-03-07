//
//  Tank.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Hull, Turret, Gun, Engine, Radio, Suspension, TankGroup, AverageTank;

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

// Pointer to the AverageTank for its TankGroup
@property (nonatomic, weak) AverageTank *averageTank;
// Pointer to the group that contains it
@property (nonatomic, weak) TankGroup *tankGroup;

// Properties that go with the tank and not a specific module
@property (nonatomic) NSString *name;
@property (nonatomic) TankNationality nationality;
@property (nonatomic) int tier;
@property (nonatomic) TankType type;
@property (nonatomic) BOOL hasTurret;
@property (nonatomic) BOOL premiumTank;
@property (nonatomic) BOOL available;
@property (nonatomic) int experienceNeeded;
@property (nonatomic) int cost;
@property (nonatomic) float crewLevel;
@property (nonatomic) int baseHitpoints;
@property (nonatomic) float topWeight;
@property (nonatomic) float stockWeight;
@property (nonatomic) float gunTraverseArc;
@property (nonatomic) float speedLimit;
@property (nonatomic) float camoValue;

// Strings to define the tanks before and after it
@property (nonatomic) NSString *parent;
@property (nonatomic) NSString *child;

// These arrays hold all possible equippable modules
@property (nonatomic) NSMutableArray *availableTurrets;
@property (nonatomic) NSMutableArray *availableEngines;
@property (nonatomic) NSMutableArray *availableSuspensions;
@property (nonatomic) NSMutableArray *availableRadios;

// The modules that are currently equipped are stored in these variables
@property (nonatomic) Hull *hull;
@property (nonatomic) Turret *turret;
@property (nonatomic) Engine *engine;
@property (nonatomic) Radio *radio;
@property (nonatomic) Suspension *suspension;

// Pass through properties
- (NSArray *)availableGuns;
- (Gun *)gun;
- (float)penetration;
- (float)aimTime;
- (float)accuracy;
- (float)rateOfFire;
- (float)gunDepression;
- (float)gunElevation;
- (BOOL)autoloader;
- (float)roundsInDrum;
- (float)drumReload;
- (float)timeBetweenShots;
- (float)loadLimit;
- (float)viewRange;
- (float)horsepower;
- (float)fireChance;
- (float)signalRange;
- (int)hullTraverse;
- (int)turretTraverse;

// Calculated properties
- (int)hitpoints;
- (float)weight;
- (float)specificPower;
- (float)damagePerMinute;
- (float)reloadTime;
- (float)alphaDamage;
- (BOOL)isStock;
- (BOOL)isTop;

// Armor Properties
- (float)frontalHullArmor;
- (float)sideHullArmor;
- (float)rearHullArmor;
- (float)frontalTurretArmor;
- (float)sideTurretArmor;
- (float)rearTurretArmor;
- (float)effectiveFrontalHullArmor;
- (float)effectiveSideHullArmor;
- (float)effectiveRearHullArmor;
- (float)effectiveFrontalTurretArmor;
- (float)effectiveSideTurretArmor;
- (float)effectiveRearTurretArmor;

// Set to Stock or Top Values
- (void)setAllValuesStock;
- (void)setAllValuesTop;
    
// Helper Methods
- (BOOL)isTopTurretNeededForTopGun;
- (BOOL)validate;
- (BOOL)validateModuleArray:(NSString *)moduleArrayString;
- (int)totalExperienceNeeded;
- (float)calculateProgressiveStatWithNominalStat:(float)nominalStat
                             effectiveSkillLevel:(float)effectiveSkillLevel
                               andEquipmentBonus:(float)equipmentBonus;
- (float)calculateDegressiveStatWithNominalStat:(float)nominalStat
                             effectiveSkillLevel:(float)effectiveSkillLevel
                               andEquipmentBonus:(float)equipmentBonus;
- (float)topRateOfFire;
- (float)fastestReload;
- (float)fastestAimTime;
- (float)crewSkillLevel;
- (float)skillLevelVentAndBIA;

// Methods used to display params
- (UIImage *)imageForTankType;
- (NSString *)stringNationality;
- (NSString *)stringTankType;
- (NSString *)stringNationalityAndType;
NSString *romanStringFromInt (long convert);

// Init methods
- (id)initWithDict:(NSDictionary *)dict;

// Override Methods
- (NSString *)description;

// Used by the init method to set the enums
TankNationality fetchTankNationality (NSString *nation);
TankType fetchTankType (NSString *type);


@end
