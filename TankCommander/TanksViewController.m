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

@interface TanksViewController ()

@end

@implementation TanksViewController

@synthesize tankGroup, tankView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"TankCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"TankCell"];
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
        [[tvc view] setBackgroundColor:[UIColor blueColor]];
        [tvc setTank:t];
        
        [[self navigationController] pushViewController:tvc animated:YES];
    }
}

@end













