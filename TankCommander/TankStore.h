//
//  TankStore.h
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tier;

@interface TankStore : NSObject
{
    NSNumber *currentVersion;
    BOOL tanksLoaded;
}

@property (nonatomic) Tier *tier1;
@property (nonatomic) Tier *tier2;
@property (nonatomic) Tier *tier3;
@property (nonatomic) Tier *tier4;
@property (nonatomic) Tier *tier5;
@property (nonatomic) Tier *tier6;
@property (nonatomic) Tier *tier7;
@property (nonatomic) Tier *tier8;
@property (nonatomic) Tier *tier9;
@property (nonatomic) Tier *tier10;

+ (TankStore *)allTanks;
- (void)loadTanks;
- (int)count;
- (NSArray *)combinedArray;

@end
