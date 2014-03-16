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

@interface TankComparisonTableViewController ()

@end

@implementation TankComparisonTableViewController

@synthesize tankOne, tankTwo, keyHash, keyIndex;

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
        self.tankOne = t1;
        self.tankTwo = t2;
        self.keyHash = [self.tankOne attributesHash];
        self.keyIndex = [self.tankOne attributesList];
        
        // Grab the singleton data stores for formatting and tooltips
        self.format = [RCFormatting store];
        self.tooltips = [RCToolTips store];
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
    return [keyIndex count];
}

- (CompareiPadTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompareiPadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompareCell"
                                                                     forIndexPath:indexPath];
    
    // Configure the cell...
    // Get the key and the Tooltips values for the key
    NSString *key = self.keyIndex[indexPath.row];
    NSArray *keyArr = [self.tooltips valuesForKey:key];
    
    // Store the value for the first tank in an NSNumber
    NSNumber *tankOneValue = [NSNumber numberWithFloat:[[self.tankOne valueForKey:key] floatValue]];
    
    // List of keys that don't need average values
    NSArray *noAverages = @[@"roundsInDrum", @"drumReload", @"burstDamage", @"timeBetweenShots", @"loadLimit"];
    // Test for array inclusion, if the key is not present then it needs an average value displayed
    BOOL needsAverage = YES;
    if ([noAverages containsObject:key]) {
        needsAverage = NO;
    }
    
    // Then based on the above result, either find the average value or set it to nil
    NSNumber *averageTankValue;
    if (needsAverage) {
        averageTankValue = [NSNumber numberWithFloat:[[self.tankOne.averageTank valueForKey:key] floatValue]];
    } else {
        averageTankValue = nil;
    }
    
    // Check to see if the second tank has the same stat
    NSArray *tankTwoAttributes = [self.tankTwo attributesList];
    NSNumber *tankTwoValue;
    if ([self.keyIndex containsObject:key] && [tankTwoAttributes containsObject:key]) {
        // Both tanks have the same key, so grab the value
        tankTwoValue = [NSNumber numberWithFloat:[[self.tankTwo valueForKey:key] floatValue]];
    } else {
        // The second tank doesn't have the same stat, set the value to nil
        tankTwoValue = nil;
    }
    
    // Now format both numbers (or nil values) for display in the app
    NSString *tankOneString;
    NSString *tankTwoString;
    // Long conditional chain to figure out the presence and formatting of the two values
    if (tankTwoValue && [keyArr[2] isEqualToString:@"float"]) {
        // Both keys exist and are float values
        tankOneString = [NSString stringWithFormat:@"%0.2f", [tankOneValue floatValue]];
        tankTwoString = [NSString stringWithFormat:@"%0.2f", [tankTwoValue floatValue]];
    } else if (tankTwoValue) {
        // Both keys exist and are not floats
        tankOneString = [NSString stringWithFormat:@"%d", [tankOneValue integerValue]];
        tankTwoString = [NSString stringWithFormat:@"%d", [tankTwoValue integerValue]];
    } else if (!tankTwoValue && [keyArr[2] isEqualToString:@"float"]) {
        // Second key does not exist, key formatting is float
        tankOneString = [NSString stringWithFormat:@"%0.2f", [tankOneValue floatValue]];
        tankTwoString = @"--";
    } else {
        // Second key does not exist, key formatting is integer
        tankOneString = [NSString stringWithFormat:@"%d", [tankOneValue integerValue]];
        tankTwoString = @"--";
    }
    
    // Finally, because of autoloaders and other stuff, the average tank value needs to be
    // figured separately
    NSString *averageString;
    if (needsAverage && [keyArr[2] isEqualToString:@"float"]) {
        // Needs average and is a float
        averageString = [NSString stringWithFormat:@"%0.2f", [averageTankValue floatValue]];
    } else if (needsAverage) {
        // Needs average and is an int
        averageString = [NSString stringWithFormat:@"%d", [averageTankValue integerValue]];
    } else {
        // Doesn't need an average
        averageString = @"--";
    }
    
    // Finally, with all the strings figured out we can set up the cells
    [[cell statName] setText:keyArr[1]];
    [[cell tankOneValue] setText:tankOneString];
    [[cell tankTwoValue] setText:tankTwoString];
    [[cell averageValue] setText:averageString];
    [[cell averageValue] setTextColor:self.format.lightColor];
    
    return cell;
}



@end
