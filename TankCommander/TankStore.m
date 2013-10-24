//
//  TankStore.m
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankStore.h"
#import "Tank.h"
#import "Tier.h"

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

- (NSMutableDictionary *)tankDB
{
    return tankDB;
}

- (void)loadTanks
{
    // Get the path to the JSON file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Tanks" ofType:@"json"];
    // Grab the data
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // Parse the JSON into a JSON object, the type is id because it can return either an
    // array or a dictionary, but in this case we know it's a dictionary
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    // Version is for DB version control, the JSON will only be loaded if the information is new
    NSNumber *version = [json objectForKey:@"version"];
    NSLog(@"%@", version);
    
    NSDictionary *tanks = [json objectForKey:@"tanks"];
    
    NSArray *tiers = @[@"tier1",
                       @"tier2",
                       @"tier3",
                       @"tier4",
                       @"tier5",
                       @"tier6",
                       @"tier7",
                       @"tier8",
                       @"tier9",
                       @"tier10"];
    
    tankDB = [[NSMutableDictionary alloc] init];
    for (NSString *key in tiers) {
        Tier *currentTier = [[Tier alloc] initWithDict:[tanks objectForKey:key]];
        [tankDB setObject:currentTier forKey:key];
    }    
}

@end


















