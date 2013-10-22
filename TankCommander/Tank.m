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

@end
