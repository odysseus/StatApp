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
#import "RCButton.h"
#import "RCFormatting.h"
#import "RCToolTips.h"

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

- (void)reloadData
{
    [self viewDidLoad];
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
    
    SelectorView *selectorView = [[SelectorView alloc] initForIPadWithOrigin:origin andTank:tank];
    [selectorView setTankViewController:self];
    [self.view addSubview:selectorView];
    origin.y += selectorView.frame.size.height;
    
    TankSubheaderView *subheader = [[TankSubheaderView alloc] initWithPoint:origin andTank:tank];
    [subheader setTankViewController:self];
    [self.view addSubview:subheader];
    origin.y += subheader.frame.size.height;
    
    GunView *gunView = [[GunView alloc] initWithOrigin:origin andTank:tank];
    [gunView setTankViewController:self];
    [self.view addSubview:gunView];
    origin.y += gunView.frame.size.height;
    
    HullView *hullView = [[HullView alloc] initWithOrigin:origin andTank:tank];
    [hullView setTankViewController:self];
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


// Presents a popup explaining the stat when you tap on the stat's name.
- (void)fullscreenPopupFromButton:(id)sender
{
    // Grab the singleton pointers for formatting and tooltip info
    RCToolTips *tooltips = [RCToolTips store];
    RCFormatting *format = [RCFormatting store];
    
    // Capture and cast the button as an RCButton to use the dataString property
    RCButton *senderButton = (RCButton *)sender;
    
    // Simple animation to fade the view in
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fadeIn setDuration:0.3];
    [fadeIn setFromValue:[NSNumber numberWithFloat:0.0]];
    [fadeIn setToValue:[NSNumber numberWithFloat:1.0]];
    
    // Fullscreen background button to dismiss the popup
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *fullscreen = [[UIButton alloc] init];
    // Check device orientation to make sure it displays properly
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        [fullscreen setFrame:CGRectMake(0, 0, screenSize.height, screenSize.width)];
    } else {
        [fullscreen setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    }
    [fullscreen setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3]];
    
    // Add the animation to the layer
    [[fullscreen layer] addAnimation:fadeIn forKey:@"fadeIn"];
    
    // Add the subview to the main view and bring it to the front
    [senderButton.superview.superview addSubview:fullscreen];
    [senderButton bringSubviewToFront:fullscreen];
    
    // Add removeFromSuperview as the action for the button, this will dismiss the view
    [fullscreen addTarget:self
                   action:@selector(dismissView:)
         forControlEvents:UIControlEventTouchUpInside];
    
    // White square to display text
    UIView *popupSquare = [[UIView alloc] init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize popupSize = CGSizeMake(400, 360);
    CGPoint popupOrigin = CGPointMake(0, 0);
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        popupOrigin = CGPointMake(((bounds.size.height - popupSize.width) / 2), 200);
    } else {
        popupOrigin = CGPointMake(((bounds.size.width - popupSize.width) / 2), 200);
    }
    [popupSquare setFrame:CGRectMake(popupOrigin.x, popupOrigin.y, popupSize.width, popupSize.height)];
    [popupSquare setBackgroundColor:[UIColor whiteColor]];
    popupSquare.layer.cornerRadius = 10;
    popupSquare.layer.masksToBounds = YES;
    [fullscreen addSubview:popupSquare];
    
    // Fetch the values from the tooltips singleton to fill in the data
    NSArray *tooltipArr = [tooltips valuesForKey:senderButton.dataString];
    
    // Label with the stat title
    [format addLabelToView:popupSquare
                 withFrame:CGRectMake(50, 20, 300, 30)
                      text:tooltipArr[0]
                  fontSize:(format.fontSize * 1.5)
                 fontColor:format.darkColor
          andTextAlignment:NSTextAlignmentCenter];
    
    // Text view with the stat description
    UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(50, 60, 300, 260)];
    [textField setText:tooltipArr[2]];
    [textField setFont:[UIFont systemFontOfSize:format.fontSize]];
    [textField setTextColor:format.darkColor];
    [textField setUserInteractionEnabled:NO];
    
    [popupSquare addSubview:textField];
}


- (void)dismissView:(id)sender
{
    // Cast the sender into a UIView, which it should always be anyway
    UIView *senderView = (UIView *)sender;
    // Fade to opaque
    [UIView animateWithDuration:0.3 animations:^{
        // Fun fact, if you define the animation separately, the completion code fires immediately
        // rather than waiting for the delay as you would expect. This doesn't appear to be true
        // When the completion is another animation, all in all, non-intuitive behavior from that
        senderView.alpha = 0.0;
    } completion:^(BOOL finished) {
        // Then remove the view once the animation finishes
        [senderView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.view = nil;
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [self viewDidLoad];
}

@end













