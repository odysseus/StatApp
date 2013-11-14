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

@synthesize tank, nameLabel, nameAndTypeLabel, typeImage, tierValue, tankCostValue, tankXpValue, penetrationAverage,
    penetrationValue, damageAverage, damageValue, rateOfFireAverage, rateOfFireValue, damagePerMinuteAverage,
    damagePerMinuteValue, aimTimeAverage, aimTimeValue, accuracyAverage, accuracyValue, depressionAverage,
    depressionValue, elevationAverage, elevationValue, gunName, gunTier;

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
    [tierValue setText:[NSString stringWithFormat:@"%@", romanStringFromInt(tank.tier)]];
    [tankXpValue setText:[NSString stringWithFormat:@"%d", tank.experienceNeeded]];
    
    // The Gun
    [gunName setText:[NSString stringWithFormat:@"Gun: %@", tank.gun.name]];
    [gunTier setText:[NSString stringWithFormat:@"%@", romanStringFromInt(tank.gun.tier)]];
    [tankCostValue setText:[NSString stringWithFormat:@"%d", tank.cost]];
    [penetrationValue setText:[NSString stringWithFormat:@"%0.0f", tank.penetration]];
    [penetrationAverage setText:[NSString stringWithFormat:@"%0.0f", tank.averageTank.penetration]];
    [damageValue setText:[NSString stringWithFormat:@"%0.0f", tank.alphaDamage]];
    [damageAverage setText:[NSString stringWithFormat:@"%0.0f", tank.averageTank.alphaDamage]];
    [rateOfFireValue setText:[NSString stringWithFormat:@"%0.2f", tank.rateOfFire]];
    [rateOfFireAverage setText:[NSString stringWithFormat:@"%0.2f", tank.averageTank.rateOfFire]];
    [damagePerMinuteValue setText:[NSString stringWithFormat:@"%0.0f", tank.damagePerMinute]];
    [damagePerMinuteAverage setText:[NSString stringWithFormat:@"%0.0f", tank.averageTank.damagePerMinute]];
    [aimTimeValue setText:[NSString stringWithFormat:@"%0.2f", tank.aimTime]];
    [aimTimeAverage setText:[NSString stringWithFormat:@"%0.2f", tank.averageTank.aimTime]];
    [accuracyValue setText:[NSString stringWithFormat:@"%0.2f", tank.accuracy]];
    [accuracyAverage setText:[NSString stringWithFormat:@"%0.2f", tank.averageTank.accuracy]];
    [depressionValue setText:[NSString stringWithFormat:@"%0.2f", tank.gunDepression]];
    [depressionAverage setText:[NSString stringWithFormat:@"%0.2f", tank.averageTank.gunDepression]];
    [elevationValue setText:[NSString stringWithFormat:@"%0.2f", tank.gunElevation]];
    [elevationAverage setText:[NSString stringWithFormat:@"%0.2f", tank.averageTank.gunElevation]];
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
