//
//  Radio.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Radio : NSObject

@property (nonatomic) NSString *name;
@property float weight;
@property (nonatomic) float signalRange;
@property (nonatomic) BOOL stockModule;
@property (nonatomic) BOOL topModule;

@end
