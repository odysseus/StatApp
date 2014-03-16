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

@synthesize key, displayName, glossaryName, definition;

- (id)initForKey:(NSString *)k withValue:(NSNumber *)v
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

@end
