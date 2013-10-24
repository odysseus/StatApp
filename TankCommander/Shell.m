//
//  Shell.m
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Shell.h"

@implementation Shell

- (id)initWithShellIndex:(int)index andArray:(NSArray *)arr
{
    self = [super init];
    if (self) {
        self.shellType = fetchShellType(index);
        self.penetration = [arr[0] floatValue];
        self.damage = [arr[1] floatValue];
    }
    return self;
}

ShellType fetchShellType (int index)
{
    switch (index) {
        case 0:
            return ShellTypeNormal;
        case 1:
            return ShellTypeGold;
        case 2:
            return ShellTypeHE;
        default:
            return ShellTypeNormal;
    }
}

@end
