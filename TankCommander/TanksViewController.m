//
//  TanksViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TanksViewController.h"
#import "TankIPadViewController.h"
#import "TankIPhoneViewController.h"
#import "TankStore.h"
#import "Tank.h"
#import "TankCell.h"
#import "TankGroup.h"
#import "TankComparisonTableViewController.h"

@interface TanksViewController ()

@end

@implementation TanksViewController

@synthesize tankGroup, compareTank, tankViewController;

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (id)initWithTankGroup:(TankGroup *)group
{
    self = [self init];
    if (self) {
        tankGroup = group;
        UINavigationItem *n = [self navigationItem];
        [n setTitle:tankGroup.typeString];
    }
    return self;
}

- (id)initForCompareWithTankGroup:(TankGroup *)group andTank:(Tank *)tank
{
    self = [self initWithTankGroup:group];
    if (self) {
        self.compareTank = tank;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"TankCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"TankCell"];
    
    UIImage *homeImg = [UIImage imageNamed:@"homeBlue"];
    UIImage *homePressed = [UIImage imageNamed:@"homeGrey"];
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [homeBtn setBackgroundImage:homeImg forState:UIControlStateNormal];
    [homeBtn setBackgroundImage:homePressed forState:UIControlStateHighlighted];
    [homeBtn addTarget:self action:@selector(popToRootVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:homeBtn];
    
    self.navigationItem.rightBarButtonItem = home;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return tankGroup.typeString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tankGroup count];
}

- (TankCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tank *t = [tankGroup objectAtIndex:indexPath.row];
    TankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TankCell"];
    
    [[cell nameLabel] setText:t.name];
    [[cell countryLabel] setText:t.stringNationality];
    [[cell tankTypeLabel] setText:t.stringTankType];
    [[cell tankImage] setImage:t.imageForTankType];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.compareTank) {
        // Grab the tank from the selected index
        Tank *t = [tankGroup objectAtIndex:indexPath.row];
        
        // Create a comparison view instead of the tank view and set the tanks to be compared
        TankComparisonTableViewController *cvc = [[TankComparisonTableViewController alloc]
                                                  initWithTankOne:self.compareTank andTwo:t];
        [cvc setTankViewController:self.tankViewController];
        
        [self.navigationController pushViewController:cvc animated:YES];
    } else {
        // If there is no compareTank present, then the view is being initialized to view the stats
        // of a single tank, so create and push a view for that
        // Test whether the device is an iPhone or iPad
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // iPad View
            TankIPadViewController *tvc = [[TankIPadViewController alloc] init];
            Tank *t = [tankGroup objectAtIndex:indexPath.row];
            [tvc setTank:t];
            
            [[self navigationController] pushViewController:tvc animated:YES];
        } else {
            // iPhone View
            TankIPhoneViewController *tvc = [[TankIPhoneViewController alloc] init];
            Tank *t = [tankGroup objectAtIndex:indexPath.row];
            [tvc setTank:t];
            
            [[self navigationController] pushViewController:tvc animated:YES];
        }
    }
}

- (void)popToRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end













