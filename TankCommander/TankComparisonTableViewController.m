//
//  TankComparisonTableViewController.m
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "TankComparisonTableViewController.h"
#import "Tank.h"
#import "AverageTank.h"
#import "CompareiPadTableViewCell.h"
#import "RCFormatting.h"
#import "RCToolTips.h"
#import "Stat.h"
#import "StatStore.h"

@interface TankComparisonTableViewController ()

@end

@implementation TankComparisonTableViewController

@synthesize tankOne, tankTwo, combinedKeys, tankOneKeys, tankTwoKeys;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTankOne:(Tank *)t1 andTwo:(Tank *)t2
{
    self = [super init];
    if (self) {
        NSLog(@"Comparison Init");
        // Set the tanks
        self.tankOne = t1;
        self.tankTwo = t2;
        
        // Grab the singleton data stores for formatting and tooltips
        self.format = [RCFormatting store];
        
        // Grab the arrays of attributes for both tanks
        self.tankOneKeys = [self.tankOne attributesList];
        self.tankTwoKeys = [self.tankTwo attributesList];
        NSMutableArray *combined = [[NSMutableArray alloc] init];
        // Include each unique key once, so:
        // Add everything from tank one
        for (NSString *key in self.tankOneKeys) {
            [combined addObject:key];
        }
        // Then everything from tank two that wasn't in tank one
        for (NSString *key in self.tankTwoKeys) {
            if (![combined containsObject:key]) {
                [combined addObject:key];
            }
        }
        self.combinedKeys = combined;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"CompareiPadTableViewCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"CompareCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.combinedKeys count];
}

- (CompareiPadTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompareiPadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompareCell"
                                                                     forIndexPath:indexPath];
    
    StatStore *stats = [StatStore store];
    
    // Configure the cell...
    // Get the key and the associated Stat object
    NSString *key = self.combinedKeys[indexPath.row];
    Stat *stat = [stats statForKey:key];
    
    // Three tanks will be displayed (compare1, compare2, average) and they can all have a different list of
    // attributes, so first we need to figure out which ones need displaying
    
    // First, the list of keys that aren't on the average tank
    NSArray *noAverages = @[@"roundsInDrum", @"drumReload", @"burstDamage", @"timeBetweenShots", @"loadLimit"];
    // Test for array inclusion, if the key is not present then it needs an average value displayed
    BOOL needsAverage = YES;
    if ([noAverages containsObject:key]) {
        needsAverage = NO;
    }
    
    // If it needs an average, begin that process
    Stat *averageStat;
    if (needsAverage) {
        // We know that one tank or the other has this attribute, so we need to figure out which
        // Default to tankOne
        if ([self.tankOneKeys containsObject:key]) {
            averageStat = [[Stat alloc] initWithStat:stat
                                            andValue:[self.tankOne.averageTank valueForKey:key]];
        } else {
            // Because the key exists in the combinedKeys, we know it exists on one or the other so
            // we can call this without fear of raising an error
            averageStat = [[Stat alloc] initWithStat:stat
                                            andValue:[self.tankTwo.averageTank valueForKey:key]];
        }
    }
    
    // Next find the stat for tankOne
    Stat *tankOneStat;
    if ([self.tankOneKeys containsObject:key]) {
        // The key exists on tankOne, so init the stat with the value
        tankOneStat = [[Stat alloc] initWithStat:stat
                                        andValue:[NSNumber numberWithFloat:
                                                  [[self.tankOne valueForKey:key] floatValue]]];
    }
    
    // And the stat for tankTwo
    Stat *tankTwoStat;
    if ([self.tankTwoKeys containsObject:key]) {
        tankTwoStat = [[Stat alloc] initWithStat:stat
                                        andValue:[NSNumber numberWithFloat:
                                                  [[self.tankTwo valueForKey:key] floatValue]]];
    }
    
    // Now that we have all three stats (if they exist) we need to format them
    
    // tankOne
    NSString *tankOneStatString;
    if (tankOneStat) {
        tankOneStatString = [tankOneStat formatted];
    } else {
        tankOneStatString = @"--";
    }
    
    // tankTwo
    NSString *tankTwoStatString;
    if (tankTwoStat) {
        tankTwoStatString = [tankTwoStat formatted];
    } else {
        tankTwoStatString = @"--";
    }
    
    // average
    NSString *averageStatString;
    if (averageStat) {
        averageStatString = [averageStat formatted];
    } else {
        averageStatString = @"--";
    }
    
    [[cell statName] setText:stat.displayName];
    [[cell tankOneValue] setText:tankOneStatString];
    [[cell tankTwoValue] setText:tankTwoStatString];
    [[cell averageValue] setText:averageStatString];
    [[cell averageValue] setTextColor:self.format.lightColor];
    
    return cell;
}



@end
