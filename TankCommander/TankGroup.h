//
//  TankGroup.h
//  TankCommander
//
//  Created by Ryan Case on 10/27/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tank;

@interface TankGroup : NSObject

@property (nonatomic) NSMutableArray *group;

- (void)addObject:(id)object;
- (NSArray *)filteredArrayUsingPredicate:(NSPredicate *)predicate;
- (Tank *)findTankByName:(NSString *)name;

- (NSArray *)sortTanksByKey:(NSString *)key smallerValuesAreBetter:(BOOL)yesno;
- (NSArray *)sortedListForKey:(NSString *)key smallerValuesAreBetter:(BOOL)yesno;

- (void)setAllRoundsToNormalRounds;
- (void)setAllRoundsToGoldRounds;
- (void)setAllRoundsToHERounds;

@end
