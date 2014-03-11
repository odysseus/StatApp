//
//  RCToolTips.m
//  TankCommander
//
//  Created by Ryan Case on 3/10/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "RCToolTips.h"

@implementation RCToolTips

+ (RCToolTips *)store
{
    static RCToolTips *singleton = nil;
    
    if (nil == singleton) {
        singleton = [[[self class] alloc] init];
    }
    
    return singleton;
}

@end
