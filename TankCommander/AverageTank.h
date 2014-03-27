//
//  AverageTank.h
//  TankCommander
//
//  Created by Ryan Case on 11/8/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AverageTank : NSObject
// AverageTank is intended to be a class that looks like a Tank and quacks like a Tank,
// but has no complicated object structure and all assignable attributes in order to store
// the average values for all tanks within a certain tier.  This should be less CPU intensive
// than dynamically calculating them every time.

@property (nonatomic) NSString *name;
@property (nonatomic) int experienceNeeded;
@property (nonatomic) int cost;
@property (nonatomic) int hitpoints;
@property (nonatomic) int hullTraverse;
@property (nonatomic) int turretTraverse;
@property (nonatomic) float viewRange;
@property (nonatomic) float gunTraverseArc;
@property (nonatomic) float speedLimit;
@property (nonatomic) float camoValueStationary;
@property (nonatomic) float camoValueMoving;
@property (nonatomic) float camoValueShooting;
@property (nonatomic) float penetration;
@property (nonatomic) float aimTime;
@property (nonatomic) float accuracy;
@property (nonatomic) float rateOfFire;
@property (nonatomic) float gunDepression;
@property (nonatomic) float gunElevation;
@property (nonatomic) float weight;
@property (nonatomic) float specificPower;
@property (nonatomic) float damagePerMinute;
@property (nonatomic) float reloadTime;
@property (nonatomic) float alphaDamage;
@property (nonatomic) float horsepower;
@property (nonatomic) float fireChance;
@property (nonatomic) float signalRange;
@property (nonatomic) float loadLimit;
@property (nonatomic) float hardTerrainResistance;
@property (nonatomic) float mediumTerrainResistance;
@property (nonatomic) float softTerrainResistance;
@property (nonatomic) float movementDispersionGun;
@property (nonatomic) float movementDispersionSuspension;

// Armor Properties
@property (nonatomic) float frontalHullArmor;
@property (nonatomic) float sideHullArmor;
@property (nonatomic) float rearHullArmor;
@property (nonatomic) float frontalTurretArmor;
@property (nonatomic) float sideTurretArmor;
@property (nonatomic) float rearTurretArmor;
@property (nonatomic) float effectiveFrontalHullArmor;
@property (nonatomic) float effectiveSideHullArmor;
@property (nonatomic) float effectiveRearHullArmor;
@property (nonatomic) float effectiveFrontalTurretArmor;
@property (nonatomic) float effectiveSideTurretArmor;
@property (nonatomic) float effectiveRearTurretArmor;

@end
