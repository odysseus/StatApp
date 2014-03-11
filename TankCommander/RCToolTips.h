//
//  RCToolTips.h
//  TankCommander
//
//  Created by Ryan Case on 3/10/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCToolTips : NSObject

@property (nonatomic) NSDictionary *toolTips;

+ (RCToolTips *)store;

@end
