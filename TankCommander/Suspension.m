//
//  Suspension.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Suspension.h"

@implementation Suspension

@synthesize loadLimit, traverseSpeed;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.loadLimit = [[dict objectForKey:@"loadLimit"] floatValue];
        self.traverseSpeed = [[dict objectForKey:@"traverseSpeed"] floatValue];
    }
    return self;
}

@end
