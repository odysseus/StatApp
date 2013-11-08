//
//  TankGroup.h
//  TankCommander
//
//  Created by Ryan Case on 10/27/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tank, AverageTank;

@interface TankGroup : NSObject

@property (nonatomic) NSMutableArray *group;
@property (nonatomic) AverageTank *averageTank;

- (void)addObject:(id)object;
- (NSArray *)filteredArrayUsingPredicate:(NSPredicate *)predicate;
- (Tank *)findTankByName:(NSString *)name;
- (void)addAverageTank;

// Data Sorting Methods
- (NSArray *)sortedListForKey:(NSString *)key smallerValuesAreBetter:(BOOL)yesno;
- (NSArray *)percentileValuesForKey:(NSString *)key smallerValuesAreBetter:(BOOL)smallerIsBetter;

// Sample Statistical Methods
- (NSNumber *)averageValueForKey:(NSString *)key;

// Pretty Printing Methods
- (NSString *)stringSortedListForKey:(NSString *)key smallerValuesAreBetter:(BOOL)yesno;


- (void)setAllRoundsToNormalRounds;
- (void)setAllRoundsToGoldRounds;
- (void)setAllRoundsToHERounds;

@end
