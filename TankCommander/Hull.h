//
//  Hull.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Armor, Gun;

@interface Hull : NSObject <NSCopying>

@property (nonatomic) Armor *frontArmor;
@property (nonatomic) Armor *sideArmor;
@property (nonatomic) Armor *rearArmor;
@property (nonatomic) Gun *gun;
@property (nonatomic) float weight;
@property (nonatomic) float viewRange;
@property (nonatomic) NSMutableArray *availableGuns;


- (id)initWithDict:(NSDictionary *)dict forTurreted:(BOOL)hasTurret;
+ (int)count;

@end
