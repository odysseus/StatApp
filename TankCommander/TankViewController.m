//
//  TankViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/12/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankViewController.h"
#import "Tank.h"
#import "AverageTank.h"
#import "Gun.h"
#import "Hull.h"
#import "Turret.h"
#import "Engine.h"
#import "Suspension.h"
#import "Radio.h"

@interface TankViewController ()

@end

@implementation TankViewController

@synthesize tank;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    // Create a blank view to contain everything
    UIView *tankView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = tankView;
    
    // Variables to provide consistent layout and colors
    fontSize = 16.0;
    darkColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
    lightColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];

    [self renderHeader];
}

- (void)renderHeader
{
    // Tank Header objects
    UIImageView *tankClassImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 85, 40, 40)];
    [tankClassImage setImage:tank.imageForTankType];
    [self.view addSubview:tankClassImage];
    
    UILabel *tankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 80, 360, 50)];
    [tankNameLabel setText:tank.name];
    [tankNameLabel setFont:[UIFont systemFontOfSize:(fontSize * 2)]];
    [tankNameLabel setTextColor:darkColor];
    [self.view addSubview:tankNameLabel];
    
    UILabel *nationLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 120, 360, 20)];
    [nationLabel setText:tank.stringNationalityAndType];
    [nationLabel setFont:[UIFont systemFontOfSize:fontSize]];
    [nationLabel setTextColor:lightColor];
    [self.view addSubview:nationLabel];
    
    if (!tank.premiumTank) {
        UILabel *xpNeededLabel = [[UILabel alloc] initWithFrame:CGRectMake(565, 90, 40, 20)];
        [xpNeededLabel setText:NSLocalizedString(@"XP:", nil)];
        [xpNeededLabel setFont:[UIFont systemFontOfSize:(fontSize * 0.75)]];
        [xpNeededLabel setTextColor:lightColor];
        [self.view addSubview:xpNeededLabel];
        
        UILabel *xpNeededValue = [[UILabel alloc] initWithFrame:CGRectMake(615, 90, 75, 20)];
        [xpNeededValue setText:[NSString stringWithFormat:@"%d", tank.experienceNeeded]];
        [xpNeededValue setFont:[UIFont systemFontOfSize:(fontSize * 0.75)]];
        [xpNeededValue setTextColor:lightColor];
        [self.view addSubview:xpNeededValue];
    }
    
    UILabel *costLabel = [[UILabel alloc] initWithFrame:CGRectMake(565, 110, 40, 20)];
    [costLabel setText:NSLocalizedString(@"Cost:", nil)];
    [costLabel setFont:[UIFont systemFontOfSize:(fontSize * 0.75)]];
    [costLabel setTextColor:lightColor];
    [self.view addSubview:costLabel];
    
    UILabel *costValue = [[UILabel alloc] initWithFrame:CGRectMake(615, 110, 75, 20)];
    [costValue setText:[NSString stringWithFormat:@"%d", tank.cost]];
    [costValue setFont:[UIFont systemFontOfSize:(fontSize * 0.75)]];
    if (tank.premiumTank) {
        [costValue setTextColor:[UIColor orangeColor]];
    } else {
        [costValue setTextColor:lightColor];
    }
    [self.view addSubview:costValue];
    
    UILabel *tierLabel = [[UILabel alloc] initWithFrame:CGRectMake(700, 80, 50, 60)];
    [tierLabel setText:romanStringFromInt(tank.tier)];
    [tierLabel setFont:[UIFont systemFontOfSize:(fontSize * 2)]];
    [tierLabel setTextColor:darkColor];
    [self.view addSubview:tierLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    // When view is called to appear
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end













