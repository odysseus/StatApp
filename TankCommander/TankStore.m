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
#import "TankGroup.h"

static TankStore *allTanks = nil;

@implementation TankStore

@synthesize tier1, tier2, tier3, tier4, tier5, tier6, tier7, tier8, tier9, tier10;

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
        NSLog(@"TankStore init");
    }
    return self;
}

- (void)loadTanks
{
    if (!tanksLoaded) {
        // Loop through the tier files
        for (int i=1; i<=10; i++) {
            // Construct a string with the name of the tier
            NSString *tierName = [NSString stringWithFormat:@"tier%d", i];
            // Use that string to get the path to the json file for the tier
            NSString *path = [[NSBundle mainBundle] pathForResource:tierName ofType:@"json"];
            // Grab the data
            NSData *data = [NSData dataWithContentsOfFile:path];
            // Parse the JSON into a JSON object, the type is id because it can return either an
            // array or a dictionary, but in this case we know it's a dictionary
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            // Grab the dictionary with the tier information
            NSDictionary *tierDict = [json objectForKey:tierName];
            // Use that to init a new tier object
            Tier *tier = [[Tier alloc] initWithDict:tierDict];
            
            switch (i) {
                case 1:
                    self.tier1 = tier;
                    break;
                case 2:
                    self.tier2 = tier;
                    break;
                case 3:
                    self.tier3 = tier;
                    break;
                case 4:
                    self.tier4 = tier;
                    break;
                case 5:
                    self.tier5 = tier;
                    break;
                case 6:
                    self.tier6 = tier;
                    break;
                case 7:
                    self.tier7 = tier;
                    break;
                case 8:
                    self.tier8 = tier;
                    break;
                case 9:
                    self.tier9 = tier;
                    break;
                case 10:
                    self.tier10 = tier;
                    break;
                default:
                    break;
            }
            
        }
        
        self.tier1.nameString = @"Tier 1";
        self.tier2.nameString = @"Tier 2";
        self.tier3.nameString = @"Tier 3";
        self.tier4.nameString = @"Tier 4";
        self.tier5.nameString = @"Tier 5";
        self.tier6.nameString = @"Tier 6";
        self.tier7.nameString = @"Tier 7";
        self.tier8.nameString = @"Tier 8";
        self.tier9.nameString = @"Tier 9";
        self.tier10.nameString = @"Tier 10";
        
        tanksLoaded = YES;
    }
}

- (int)count
{
    return ([tier1 count] + [tier2 count] + [tier3 count] + [tier4 count] + [tier5 count] +
            [tier6 count] + [tier7 count] + [tier8 count] + [tier9 count] + [tier10 count]);
}

- (NSArray *)combinedArray
{
    // Create an array to hold everything
    NSMutableArray *combinedArray = [[NSMutableArray alloc] init];
    // Fetch the tank db
    TankStore *allTanks = [TankStore allTanks];
    // The string array will be used to iterate over all the tiers
    NSArray *tiers = @[@"tier1", @"tier2", @"tier3", @"tier4", @"tier5",
                       @"tier6", @"tier7", @"tier8", @"tier9", @"tier10"];
    // Iterate over each tier
    for (NSString *key in tiers) {
        // Fetch the tier
        Tier *currentTier = [allTanks valueForKey:key];
        // And the array containing all the tanks
        NSArray *allForTier = [[currentTier all] group];
        for (Tank *t in allForTier) {
            // Then add each tank to the final array
            [combinedArray addObject:t];
        }
    }
    // And return it
    return combinedArray;
}

- (NSArray *)validKeys
{
    NSArray *tiers = @[@"tier1", @"tier2", @"tier3", @"tier4", @"tier5",
                       @"tier6", @"tier7", @"tier8", @"tier9", @"tier10"];
    NSMutableArray *validKeys = [[NSMutableArray alloc] init];
    for (NSString *key in tiers) {
        if ([[[self valueForKey:key] all] count] > 0) {
            [validKeys addObject:key];
        }
    }
    return validKeys;
}

@end


















