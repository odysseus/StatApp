//
//  ModulesViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/18/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "ModulesViewController.h"
#import "Tank.h"
#import "ModuleCell.h"
#import "Module.h"
#import "Gun.h"
#import "Turret.h"
#import "Hull.h"
#import "TankIPadViewController.h"

@interface ModulesViewController ()

@end

@implementation ModulesViewController

@synthesize tank, moduleArray, tankViewController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTank:(Tank *)t andKey:(NSString *)key
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tank = t;
        self.moduleArray = [tank valueForKey:key];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"ModuleCell" bundle:nil];
    
    // Register this NIB which contains the cell
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"ModuleCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moduleArray count];
}

- (ModuleCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ModuleCell";
    ModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Module *mod = moduleArray[indexPath.row];
    [[cell nameLabel] setText:mod.name];
    [[cell tierLabel] setText:romanStringFromInt(mod.tier)];
    [[cell summaryLabel] setText:mod.stringSummary];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Module *mod = moduleArray[indexPath.row];
    NSString *key = [[NSString stringWithFormat:@"%@", [mod class]] lowercaseString];
    if ([key isEqualToString:@"gun"]) {
        if (tank.hasTurret) {
            [tank.turret setValue:mod forKey:key];
        } else {
            [tank.hull setValue:mod forKey:key];
        }
    // To avoid confusion, when switching turrets the gun should be set to the same gun as before, if it exists
    } else if ([key isEqualToString:@"turret"]) {
        // Convert the module to a turret and fetch the current gun
        Turret *mod = moduleArray[indexPath.row];
        Gun *currentGun = tank.gun;
        for (Gun *gun in mod.availableGuns) {
            // Run through all available guns searching for one with the same name. Two reasons to do this instead of
            // simply setting tank.gun = currentGun. 1) Some guns have different stats with diff turrets. 2) Stock
            // turrets often have fewer available guns, switching from the top turret to the stock could create an
            // impossible configuration if we don't check the names
            if ([gun.name isEqualToString:currentGun.name]) {
                mod.gun = gun;
            }
        }
        [tank setValue:mod forKey:key];
    } else {
        [tank setValue:mod forKey:key];
    }
    [tankViewController viewDidLoad];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
