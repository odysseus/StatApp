//
//  Hull.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Armor, Gun;

@interface Hull : NSObject

@property (nonatomic) Armor *frontArmor;
@property (nonatomic) Armor *sideArmor;
@property (nonatomic) Armor *rearArmor;
@property (nonatomic) float weight;
@property (nonatomic) NSMutableArray *availableGuns;
@property Gun *gun;

- (id)initWithDict:(NSDictionary *)dict forTurreted:(BOOL)hasTurret;

@end
