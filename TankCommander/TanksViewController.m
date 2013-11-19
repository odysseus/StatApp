//
//  TanksViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TanksViewController.h"
#import "TankViewController.h"
#import "TankStore.h"
#import "Tank.h"
#import "TankCell.h"
#import "TankGroup.h"

@interface TanksViewController ()

@end

@implementation TanksViewController

@synthesize tankGroup;

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        [n setTitle:NSLocalizedString(@"Tanks", nil])];
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
    TankViewController *tvc = [[TankViewController alloc] init];
    Tank *t = [tankGroup objectAtIndex:indexPath.row];
    [tvc setTank:t];
    
    [[self navigationController] pushViewController:tvc animated:YES];
}

@end













