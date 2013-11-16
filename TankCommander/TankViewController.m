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
    
    // Debugging Colors to show the outlines of the different views
    debugGreen = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:1.0];
    debugBlue = [UIColor colorWithRed:0.9 green:0.9 blue:1.0 alpha:1.0];
    debugPurple = [UIColor colorWithRed:0.9 green:0.8 blue:1.0 alpha:1.0];
    
    CGPoint origin = CGPointMake(0, 70);
    
    UIView *headerView = [self renderHeaderFromPoint:origin];
    [self.view addSubview:headerView];
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

- (UILabel *)addLabelToView:(UIView *)view
                  withFrame:(CGRect)frame
                       text:(NSString *)text
                   fontSize:(CGFloat)size
               andFontColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setTextColor:color];
    // If the supplied UIView is nil, add it to self.view by default
    if (!view) {
        [self.view addSubview:label];
    } else {
        [view addSubview:label];
    }
    return label;
}

- (UIView *)renderHeaderFromPoint:(CGPoint)point
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(point.x,
                                                                  point.y,
                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                  60)];
    // Setting a nonwhite background for debugging purposes
    [headerView setBackgroundColor:debugBlue];
    
    // Tank Type Image
    UIImageView *tankClassImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    [tankClassImage setImage:tank.imageForTankType];
    [headerView addSubview:tankClassImage];
    
    // Tank Name
    [self addLabelToView:headerView
               withFrame:CGRectMake(60, 0, 360, 50)
                    text:tank.name
                fontSize:(fontSize * 2)
            andFontColor:darkColor];
    
    // Tank Nationality and Type
    [self addLabelToView:headerView
               withFrame:CGRectMake(60, 40, 360, 20)
                    text:tank.stringNationalityAndType
                fontSize:fontSize
            andFontColor:lightColor];
    
    // Experience fields will only show on non-premium tanks
    if (!tank.premiumTank) {
        // Experience Needed Label
        [self addLabelToView:headerView
                   withFrame:CGRectMake(565, 10, 40, 20)
                        text:NSLocalizedString(@"XP:", nil)
                    fontSize:(fontSize * 0.75)
                andFontColor:lightColor];
        
        // Experience Needed Value
        [self addLabelToView:headerView
                   withFrame:CGRectMake(615, 10, 75, 20)
                        text:[NSString stringWithFormat:@"%d", tank.experienceNeeded]
                    fontSize:(fontSize * 0.75)
                andFontColor:lightColor];
    }
    
    // Cost label
    [self addLabelToView:headerView
               withFrame:CGRectMake(565, 30, 40, 20)
                    text:NSLocalizedString(@"Cost:", nil)
                fontSize:(fontSize * 0.75)
            andFontColor:lightColor];
    
    // Cost value (Capturing the pointer to conditionally set the color of the cost)
    UILabel *costValue = [self addLabelToView:headerView
                                    withFrame:CGRectMake(615, 30, 75, 20)
                                         text:[NSString stringWithFormat:@"%d", tank.cost]
                                     fontSize:(fontSize * 0.75)
                                 andFontColor:lightColor];
    // Display cost differently if the tank is a premium
    if (tank.premiumTank) {
        [costValue setTextColor:[UIColor orangeColor]];
    }
    
    // Tank Tier as a Roman Numeral
    [self addLabelToView:headerView
               withFrame:CGRectMake(700, 0, 50, 60)
                    text:romanStringFromInt(tank.tier)
                fontSize:(fontSize * 2)
            andFontColor:darkColor];
    
    return headerView;
}

@end













