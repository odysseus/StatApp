//
//  Radio.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@interface Radio : Module

@property (nonatomic) float signalRange;


- (id)initWithDict:(NSDictionary *)dict;

- (NSString *)description;
+ (int)count;


@end
