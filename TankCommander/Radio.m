//
//  Radio.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Radio.h"

@implementation Radio

@synthesize signalRange;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.signalRange = [[dict objectForKey:@"signalRange"] floatValue];
    }
    return self;
}

- (NSString *)description
{
    return self.name;
}

@end
