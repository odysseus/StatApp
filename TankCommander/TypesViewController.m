//
//  TypesViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/16/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TypesViewController.h"
#import "Tier.h"
#import "TypeCell.h"
#import "TankGroup.h"
#import "TanksViewController.h"

@interface TypesViewController ()

@end

@implementation TypesViewController

@synthesize keys, tier;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (id)initWithTier:(Tier *)t
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        tier = t;
        keys = [tier fetchValidKeys];
        UINavigationItem *n = [self navigationItem];
        [n setTitle:tier.nameString];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"TypeCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"TypeCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return tier.nameString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [keys count];
}

- (TypeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TypeCell";
    TypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *key = keys[indexPath.row];
    TankGroup *currentGroup = [tier valueForKey:key];
    [[cell typeLabel] setText:[currentGroup typeString]];
    [[cell typeImage] setImage:[self imageForKey:key]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TankGroup *group = [tier valueForKey:keys[indexPath.row]];
    TanksViewController *tvc = [[TanksViewController alloc] initWithTankGroup:group];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
    UIImage *result = [UIImage imageNamed:@"default"];
    if ([key  isEqual: @"lightTanks"]) {
        return [UIImage imageNamed:@"lightTank"];
    } else if ([key isEqual:@"mediumTanks"]) {
        return [UIImage imageNamed:@"mediumTank"];
    } else if ([key isEqualToString:@"heavyTanks"]) {
        return [UIImage imageNamed:@"heavyTank"];
    } else if ([key isEqualToString:@"SPGs"]) {
        return [UIImage imageNamed:@"spg"];
    } else if ([key isEqualToString:@"tankDestroyers"]) {
        return [UIImage imageNamed:@"tankDestroyer"];
    }
    return result;
}

@end
