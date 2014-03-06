//
//  TankViewController.m
//  TankCommander
//
//  Created by Ryan Case on 11/12/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankIPadViewController.h"
#import "Tank.h"
#import "TankHeaderView.h"
#import "TankSubheaderView.h"
#import "HullView.h"
#import "GunView.h"
#import "TurretView.h"
#import "EngineView.h"
#import "RadioView.h"
#import "SuspensionView.h"
#import "SelectorView.h"

@interface TankIPadViewController ()

@end

@implementation TankIPadViewController

@synthesize tank;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Override
    }
    return self;
}

- (void)loadView
{
    // Create a blank view to contain everything
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIView *tankView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scrollView addSubview:tankView];
    [scrollView setContentSize:[tankView bounds].size];
    self.view = scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    // When view is called to appear
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    for (UIView *sv in self.view.subviews) {
        [sv removeFromSuperview];
    }
    
    CGPoint origin = CGPointMake(0, 0);
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        origin.x += 150;
    }
    
    TankHeaderView *headerView = [[TankHeaderView alloc] initWithPoint:origin andTank:tank];
    [self.view addSubview:headerView];
    // Advance the Y value on the origin point so that subsequent views render from the right spot
    origin.y += headerView.frame.size.height;
    
    SelectorView *selectorView = [[SelectorView alloc] initWithOrigin:origin andTank:tank];
    [selectorView setTankViewController:self];
    [self.view addSubview:selectorView];
    origin.y += selectorView.frame.size.height;
    
    TankSubheaderView *subheader = [[TankSubheaderView alloc] initWithPoint:origin andTank:tank];
    [self.view addSubview:subheader];
    origin.y += subheader.frame.size.height;
    
    GunView *gunView = [[GunView alloc] initWithOrigin:origin andTank:tank];
    [gunView setTankViewController:self];
    [self.view addSubview:gunView];
    origin.y += gunView.frame.size.height;
    
    HullView *hullView = [[HullView alloc] initWithOrigin:origin andTank:tank];
    [self.view addSubview:hullView];
    origin.y += hullView.frame.size.height;
    
    if (tank.hasTurret) {
        TurretView *turretView = [[TurretView alloc] initWithOrigin:origin andTank:tank];
        [turretView setTankViewController:self];
        [self.view addSubview:turretView];
        origin.y += turretView.frame.size.height;
    }
    
    EngineView *engineView = [[EngineView alloc] initWithOrigin:origin andTank:tank];
    [engineView setTankViewController:self];
    [self.view addSubview:engineView];
    origin.y += engineView.frame.size.height;
    
    RadioView *radioView = [[RadioView alloc] initWithOrigin:origin andTank:tank];
    [radioView setTankViewController:self];
    [self.view addSubview:radioView];
    origin.y += radioView.frame.size.height;
    
    SuspensionView *suspensionView = [[SuspensionView alloc] initWithOrigin:origin andTank:tank];
    [suspensionView setTankViewController:self];
    [self.view addSubview:suspensionView];
    origin.y += suspensionView.frame.size.height;
    
    origin.y += 100;
    
    UIScrollView *scrollView = (UIScrollView *)self.view;
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, origin.y)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.view = nil;
    // Dispose of any resources that can be recreated.
}

- (UILabel *)addLabelToView:(UIView *)view
                  withFrame:(CGRect)frame
                       text:(NSString *)text
                   fontSize:(CGFloat)size
                  fontColor:(UIColor *)color
           andTextAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setFont:[UIFont systemFontOfSize:size]];
    [label setTextColor:color];
    [label setTextAlignment:alignment];
    // If the supplied UIView is nil, add it to self.view by default
    if (!view) {
        [self.view addSubview:label];
    } else {
        [view addSubview:label];
    }
    return label;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [self viewDidLoad];
}

@end













