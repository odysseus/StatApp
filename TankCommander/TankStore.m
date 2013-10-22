//
//  TankStore.m
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankStore.h"

static TankStore *allTanks = nil;

@implementation TankStore

+ (TankStore *)allTanks
{
    if (!allTanks)
        allTanks = [[super allocWithZone:nil] init];
    return allTanks;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self allTanks];
}

- (id)init
{
    self = [super init];
    if (self) {
        if (!currentVersion) {
            currentVersion = 0;
        }
    }
    return self;
}

- (NSDictionary *)tankDB
{
    return tankDB;
}

- (void)loadTanks
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Tanks" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    NSDictionary *tanks = [json objectForKey:@"tanks"];
    NSLog(@"%@", tanks);
}

@end
