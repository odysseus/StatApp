//
//  TankViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/12/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankViewController.h"
#import "Tank.h"

@interface TankViewController ()

@end

@implementation TankViewController

@synthesize tank, nameLabel, nameAndTypeLabel, typeImage;

- (id)init
{
    self = [super initWithNibName:@"TankViewController" bundle:nil];
    if (self) {
        // Override
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [nameLabel setText:tank.name];
    [nameAndTypeLabel setText:tank.stringNationalityAndType];
    [typeImage setImage:tank.imageForTankType];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
