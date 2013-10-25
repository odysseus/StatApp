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
    if (!allTanks) {
        allTanks = [[super allocWithZone:nil] init];
        [allTanks loadTanks];
    }
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

- (void)loadTanks
{
    if (!tanksLoaded) {
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
        
        // Add each tier
        self.tier1 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier1"]];
        self.tier2 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier2"]];
        self.tier3 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier3"]];
        self.tier4 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier4"]];
        self.tier5 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier5"]];
        self.tier6 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier6"]];
        self.tier7 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier7"]];
        self.tier8 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier8"]];
        self.tier9 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier9"]];
        self.tier10 = [[Tier alloc] initWithDict:[tanks objectForKey:@"tier10"]];
        
        tanksLoaded = YES;
    }
}

@end


















