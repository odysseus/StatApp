//
//  TankStore.m
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankStore.h"
#import "Tank.h"

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
    // Get the path to the JSON file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Tanks" ofType:@"json"];
    // Grab the data
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    // Parse the JSON into a JSON object, the type is id because it can return either an
    // array or a dictionary, but in this case we know it's a dictionary
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    // Version is for version control, and the "tanks" key contains all the actual data
    NSNumber *version = [json objectForKey:@"version"];
    NSDictionary *tanks = [json objectForKey:@"tanks"];
    NSDictionary *tiger2 = [[[tanks objectForKey:@"tier8"] objectForKey:@"heavyTanks"] objectForKey:@"tiger 2"];
    
    NSLog(@"Version: %@", version);
            
    for (id key in tiger2) {
        NSLog(@"%@", key);
    }

}

@end
