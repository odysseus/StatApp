//
//  Shell.h
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shell : NSObject

typedef enum {
    ShellTypeNormal,
    ShellTypeGold,
    ShellTypeHE
} ShellType;

@property ShellType shellType;
@property float penetration;
@property float damage;

@end
