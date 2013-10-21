//
//  Armor.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Armor : NSObject

@property (nonatomic) float thickness;
@property (nonatomic) float angle;

- (float)effectiveThickness;
float cosineWithDegrees(float radians);


@end
