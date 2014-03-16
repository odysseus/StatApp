//
//  StatStore.h
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Stat;

@interface StatStore : NSObject

@property (nonatomic) NSDictionary *stats;

+ (StatStore *)store;

- (Stat *)statForKey:(NSString *)key;

@end
