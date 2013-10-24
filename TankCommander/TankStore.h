//
//  TankStore.h
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TankStore : NSObject
{
    NSMutableDictionary *tankDB;
    NSNumber *currentVersion;
}

+ (TankStore *)allTanks;
- (NSMutableDictionary *)tankDB;
- (void)loadTanks;

@end
