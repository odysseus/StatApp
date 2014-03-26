//
//  Hull.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "Hull.h"
#import "Armor.h"
#import "Gun.h"

static int hullCount = 0;

@implementation Hull

@synthesize weight, frontArmor, sideArmor, rearArmor, availableGuns, gun, viewRange;

- (id)initWithDict:(NSDictionary *)dict forTurreted:(BOOL)hasTurret
{
    self = [super init];
    if (self) {
        self.weight = [[dict objectForKey:@"weight"] floatValue];
        self.frontArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"frontArmor"]];
        self.sideArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"sideArmor"]];
        self.rearArmor = [[Armor alloc] initWithArray:[dict objectForKey:@"rearArmor"]];
        if (!hasTurret) {
            self.viewRange = [[dict objectForKey:@"viewRange"] floatValue];
            
            availableGuns = [[NSMutableArray alloc] init];
            NSDictionary *gunValues = [dict objectForKey:@"availableGuns"];
            for (id key in gunValues) {
                NSDictionary *gunDict = [gunValues objectForKey:key];
                Gun *currentGun = [[Gun alloc] initWithDict: gunDict];
                [availableGuns addObject:currentGun];
                if (currentGun.topModule) {
                    self.gun = currentGun;
                }
            }
            [availableGuns sortUsingSelector:@selector(compare:)];
        }
        
        hullCount++;
    }
    return self;
}

+ (int)count
{
    return hullCount;
}

- (id)copyWithZone:(NSZone *)zone
{
    Hull *copy = [[[self class] allocWithZone:zone] init];
    NSArray *attributes = @[@"frontArmor", @"sideArmor", @"rearArmor", @"viewRange"];
    for (NSString *key in attributes) {
        [copy setValue:[[self valueForKey:key] copyWithZone:zone] forKey:key];
    }
    copy.weight = self.weight;
    copy.viewRange = self.viewRange;
    
    copy.availableGuns = [[NSMutableArray alloc] initWithArray:self.availableGuns copyItems:YES];
    
    return copy;
}


@end
