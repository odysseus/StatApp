//
//  Shell.m
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Shell.h"

@implementation Shell

- (id)initWithArr:(NSArray *)arr
{
    self = [super init];
    if (self) {
        self.penetration = [arr[0] floatValue];
        self.damage = [arr[1] floatValue];
        self.cost = [arr[2] floatValue];
        if ([arr[3] boolValue]) {
            self.isPremiumShell = YES;
        } else {
            self.isPremiumShell = NO;
        }
        [self setShellTypeWithString:arr[4]];
    }
    return self;
}

-(void)setShellTypeWithString:(NSString *)shellTypeString
{
    if (self.isPremiumShell) {
        self.shellType = ShellTypeGold;
    } else if ([shellTypeString isEqualToString:@"high_explosive"]) {
        self.shellType = ShellTypeHE;
    } else  {
        self.shellType = ShellTypeNormal;
    }
}

- (NSString *)description
{
    if (self.shellType == ShellTypeGold) {
        return @"Gold";
    } else if (self.shellType == ShellTypeHE) {
        return @"HE";
    } else {
        return @"Normal";
    }
}

@end
