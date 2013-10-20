//
//  Tank.h
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tank : NSObject

@property (nonatomic) float armorThickness;
@property (nonatomic) float armorAngle;

- (float)normalizedEffectiveArmor;
float degCos(float radians);

@end
