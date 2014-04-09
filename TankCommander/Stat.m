//
//  Stat.m
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "Stat.h"
#import "StatStore.h"

@implementation Stat

@synthesize key, displayName, glossaryName, definition, value, statType, largerValuesAreBetter;

- (id)initWithKey:(NSString *)k andValue:(NSNumber *)v
{
    self = [super init];
    if (self) {
        StatStore *store = [StatStore store];
        Stat *data = [store statForKey:k];
        self.key = data.key;
        self.value = v;
        self.definition = data.definition;
        self.displayName = data.displayName;
        self.glossaryName = data.glossaryName;
        self.statType = data.statType;
    }
    return self;
}

- (id)initWithStat:(Stat *)s andValue:(NSNumber *)v
{
    self = [super init];
    if (self) {
        self.key = s.key;
        self.definition = s.definition;
        self.displayName = s.displayName;
        self.glossaryName = s.glossaryName;
        self.statType = s.statType;
        self.value = v;
    }
    return self;
}

- (NSString *)formatted
{
    NSString *final;
    if (self.statType ==FloatStat) {
        final = [NSString stringWithFormat:@"%0.2f", [self.value floatValue]];
    } else {
        final = [NSString stringWithFormat:@"%ld", (long)[self.value integerValue]];
    }
    return final;
}

- (int)compareStatTo:(Stat *)otherStat
{
    if (self.largerValuesAreBetter) {
        if ([self.value floatValue] > [otherStat.value floatValue]) {
            return 1;
        } else if ([self.value floatValue] < [otherStat.value floatValue]) {
            return -1;
        } else {
            return 0;
        }
    } else {
        if ([self.value floatValue] > [otherStat.value floatValue]) {
            return -1;
        } else if ([self.value floatValue] < [otherStat.value floatValue]) {
            return 1;
        } else {
            return 0;
        }
    }
}

@end


















