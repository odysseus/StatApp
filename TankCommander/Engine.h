//
//  Engine.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@interface Engine : Module

@property (nonatomic) float horsepower;
@property (nonatomic) float fireChance;


- (id)initWithDict:(NSDictionary *)dict;

- (NSString *)description;


@end
