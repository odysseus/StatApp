//
//  Stat.h
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stat : NSObject

typedef enum StatType : NSUInteger {
    FloatStat,
    IntStat
} StatType;

@property (nonatomic) NSString *key;
@property (nonatomic) NSString *displayName;
@property (nonatomic) NSString *glossaryName;
@property (nonatomic) NSString *definition;
@property (nonatomic) NSNumber *value;
@property (nonatomic) StatType statType;

- (id)initForKey:(NSString *)k withValue:(NSNumber *)v;

@end
