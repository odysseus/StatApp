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
    NSDictionary *tankDB;
    NSNumber *currentVersion;
}

+ (TankStore *)allTanks;
- (NSDictionary *)tankDB;
- (void)loadTanks;

@end
