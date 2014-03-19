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
#import "Stat.h"
#import "StatStore.h"

@interface TankComparisonTableViewController ()

@end

@implementation TankComparisonTableViewController

@synthesize tankOne, tankTwo, combinedKeys, tankOneKeys, tankTwoKeys, tankViewController;

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
    UINib *nib;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nib = [UINib nibWithNibName:@"CompareiPadTableViewCell" bundle:nil];
    } else {
        nib = [UINib nibWithNibName:@"CompareiPhoneTableViewCell" bundle:nil];
    }
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"CompareCell"];
    
    // Other Setup
    // Create a bar button item that pops to the root view controller so you don't have to hit
    // "Back" seven times when going from a comparison view
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithTitle:@"Home"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self.navigationController
                                                            action:@selector(popToRootViewControllerAnimated:)];
    UIBarButtonItem *tank = [[UIBarButtonItem alloc] initWithTitle:self.tankOne.name
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(popToTankViewController)];
    
    NSArray *rightBarButtons = @[home, tank];
    self.navigationItem.rightBarButtonItems = rightBarButtons;
}

- (void)popToTankViewController
{
    [self.navigationController popToViewController:self.tankViewController animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    header.frame = CGRectMake(0, 0, width, 60);
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *tankOneName = [self.format addLabelToView:header
                                             withFrame:CGRectMake(10, 24, 100, 18)
                                                  text:self.tankOne.name
                                              fontSize:14
                                             fontColor:self.format.darkColor
                                      andTextAlignment:NSTextAlignmentCenter];
    tankOneName.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleRightMargin;
    
    UILabel *tankTwoName = [self.format addLabelToView:header
                                             withFrame:CGRectMake(110, 24, 100, 18)
                                                  text:self.tankTwo.name
                                              fontSize:14
                                             fontColor:self.format.darkColor
                                      andTextAlignment:NSTextAlignmentCenter];
    tankTwoName.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleLeftMargin;
    
    UILabel *averageLabel = [self.format addLabelToView:header
                                              withFrame:CGRectMake(210, 24, 100, 18)
                                                   text:@"Average"
                                               fontSize:14
                                              fontColor:self.format.darkColor
                                       andTextAlignment:NSTextAlignmentCenter];
    averageLabel.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        tankOneName.frame = CGRectMake(320, 24, 140, 18);
        tankOneName.font = [UIFont systemFontOfSize:17];
        tankOneName.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleWidth;
        
        tankTwoName.frame = CGRectMake(470, 24, 140, 18);
        tankTwoName.font = [UIFont systemFontOfSize:17];
        tankTwoName.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleWidth;
        
        averageLabel.frame = CGRectMake(620, 24, 140, 18);
        averageLabel.font = [UIFont systemFontOfSize:17];
        averageLabel.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleWidth;
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 44;
    } else {
        return 60;
    }
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
        // Use the Stat method to return a formatted string
        tankOneStatString = [tankOneStat formatted];
    } else {
        // If the stat doesn't exist, just use dashes
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
    
    // Setting the strings
    [[cell statName] setText:stat.displayName];
    [[cell tankOneValue] setText:tankOneStatString];
    [[cell tankTwoValue] setText:tankTwoStatString];
    [[cell averageValue] setText:averageStatString];
    
    // Setting the colors
    // Highlight the better stat with green
    if (tankOneStat && tankTwoStat) {
        // If both compare tanks have the stat we can continue
        // REFACTORING CAVEAT: Don't be tempted to remove the seemingly redundant code that
        // sets the color for both labels every time. Because iOS dequeues and reuses cells,
        // once the background color has been set it will stay that way if it is not set
        // every time, leading to a lot of erroneous highlighting when you scroll back up
        if (stat.largerValuesAreBetter) {
            // If the better value is the larger one:
            if ([tankOneStat.value floatValue] == [tankTwoStat.value floatValue]) {
                // Make them both yellow if they are equal
                [[cell tankOneValue] setBackgroundColor:self.format.highlightYellow];
                [[cell tankTwoValue] setBackgroundColor:self.format.highlightYellow];
            } else if ([tankOneStat.value floatValue] > [tankTwoStat.value floatValue]) {
                // Place a light green highlight background on whichever cell wins the comparison
                [[cell tankOneValue] setBackgroundColor:self.format.highlightGreen];
                [[cell tankTwoValue] setBackgroundColor:[UIColor clearColor]];
            } else {
                [[cell tankTwoValue] setBackgroundColor:self.format.highlightGreen];
                [[cell tankOneValue] setBackgroundColor:[UIColor clearColor]];
            }
        } else {
            // The better value is the smaller one
            if ([tankOneStat.value floatValue] == [tankTwoStat.value floatValue]) {
                [[cell tankOneValue] setBackgroundColor:self.format.highlightYellow];
                [[cell tankTwoValue] setBackgroundColor:self.format.highlightYellow];
            } else if ([tankOneStat.value floatValue] < [tankTwoStat.value floatValue]) {
                // Place a light green highlight background on whichever cell wins the comparison
                [[cell tankOneValue] setBackgroundColor:self.format.highlightGreen];
                [[cell tankTwoValue] setBackgroundColor:[UIColor clearColor]];
            } else {
                [[cell tankTwoValue] setBackgroundColor:self.format.highlightGreen];
                [[cell tankOneValue] setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
    // Set the average value to a light gray
    [[cell averageValue] setTextColor:self.format.lightColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.combinedKeys[indexPath.row];
    Stat *stat = [[StatStore store] statForKey:key];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIView *popup = [self.format fullscreenPopupForKey:stat.key];
        [self.view addSubview:popup];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else {
        UIViewController *vc = [self.format iPhoneStatViewControllerForStat:stat];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end



























