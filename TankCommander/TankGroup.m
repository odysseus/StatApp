//
//  TankGroup.m
//  TankCommander
//
//  Created by Ryan Case on 10/27/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankGroup.h"
#import "Tank.h"

@implementation TankGroup

@synthesize group;

- (id)init
{
    self = [super init];
    if (self) {
        self.group = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObject:(id)object
{
    [group addObject:object];
}

- (NSArray *)filteredArrayUsingPredicate:(NSPredicate *)predicate
{
    NSArray *result =  [group filteredArrayUsingPredicate:predicate];
    return result;
}

- (Tank *)findTankByName:(NSString *)name
{
    Tank *result = [group filteredArrayUsingPredicate:
                    [NSPredicate predicateWithFormat:@"self.name == %@", name]][0];
    if (result) {
        return result;
    } else {
        return [[Tank alloc] init];
    }
}

@end
