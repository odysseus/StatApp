//
//  Radio.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Radio.h"

static int radioCount = 0;

@implementation Radio

@synthesize signalRange;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self) {
        self.signalRange = [[dict objectForKey:@"signalRange"] floatValue];
        
        radioCount++;
    }
    return self;
}

+ (int)count
{
    return radioCount;
}

- (NSString *)description
{
    return self.name;
}

- (NSString *)stringSummary
{
    return [NSString stringWithFormat:@"Signal Range: %0.2f",
            self.signalRange];
}

@end
