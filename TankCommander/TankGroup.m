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
    NSArray *result = [group filteredArrayUsingPredicate:
                    [NSPredicate predicateWithFormat:@"self.name == %@", name]];
    if ([result count] > 0) {
        return result[0];
    } else {
        Tank *error = [[Tank alloc] init];
        error.name = @"Search Failed";
        return error;
    }
}

@end
