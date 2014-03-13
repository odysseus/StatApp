//
//  SelectorView.m
//  TankCommander
//
//  Created by Ryan Case on 11/18/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "SelectorView.h"
#import "RCFormatting.h"
#import "Tank.h"
#import "TankIPadViewController.h"
#import "TankIPhoneViewController.h"
#import "Gun.h"
#import "TankGroup.h"

@implementation SelectorView

@synthesize tankViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initForIPadWithOrigin:(CGPoint)point andTank:(Tank *)t
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:CGRectMake(point.x, point.y, screenWidth, 45)];
    
    if (self) {
        RCFormatting *format = [RCFormatting store];
        tank = t;
        
        // Segmented Control for selecting all stock, or all top values
        NSArray *stockTop = @[@"Stock Values", @"Top Values"];
        UISegmentedControl *selectStockOrTop = [[UISegmentedControl alloc] initWithItems:stockTop];
        selectStockOrTop.frame = CGRectMake(179, 10, 185, 30);
        [selectStockOrTop setTintColor:format.darkColor];
        [selectStockOrTop addTarget:self
                       action:@selector(selectStockOrTop:)
             forControlEvents:UIControlEventValueChanged];
        if (tank.isStock) {
            [selectStockOrTop setSelectedSegmentIndex:0];
        } else if (tank.isTop) {
            [selectStockOrTop setSelectedSegmentIndex:1];
        } else {
            [selectStockOrTop setSelectedSegmentIndex:-1];
        }
        if (tank.premiumTank) {
            [selectStockOrTop setEnabled:NO];
        }
        [self addSubview:selectStockOrTop];
        
        // Segmented control for setting the shell type
        NSArray *shellTypes = tank.gun.stringShellArray;
        UISegmentedControl *selectShellType = [[UISegmentedControl alloc] initWithItems:shellTypes];
        selectShellType.frame = CGRectMake(404, 10, 185, 30);
        [selectShellType setTintColor:format.darkColor];
        // Add the target
        [selectShellType addTarget:self
                            action:@selector(selectShellType:)
                  forControlEvents:UIControlEventValueChanged];
        // Check for the currently selected shell type and set the highlighted segment
        if (tank.gun.round.shellType == ShellTypeNormal) {
            [selectShellType setSelectedSegmentIndex:0];
        } else if (tank.gun.round.shellType == ShellTypeGold) {
            [selectShellType setSelectedSegmentIndex:1];
        } else if (tank.gun.round.shellType == ShellTypeHE) {
            [selectShellType setSelectedSegmentIndex:2];
        } else {
            [selectShellType setSelectedSegmentIndex:-1];
        }
        [self addSubview:selectShellType];
    }
    return self;
}

- (id)initForIPhoneWithOrigin:(CGPoint)point andTank:(Tank *)t
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:CGRectMake(point.x, point.y, screenWidth, 75)];
    
    if (self) {
        RCFormatting *format = [RCFormatting store];
        tank = t;
        
        // Segmented Control for selecting all stock, or all top values
        NSArray *stockTop = @[@"Stock Values", @"Top Values"];
        UISegmentedControl *selectStockOrTop = [[UISegmentedControl alloc] initWithItems:stockTop];
        selectStockOrTop.frame = CGRectMake(65, 5, 185, 30);
        [selectStockOrTop setTintColor:format.darkColor];
        [selectStockOrTop addTarget:self
                             action:@selector(selectStockOrTop:)
                   forControlEvents:UIControlEventValueChanged];
        // Checking the tank's equipped modules to see which segment to highlight
        // If the tank only has one set of modules, like premium and tier 10 tanks, set the top segment
        // and disable the controller, since it wouldn't do anything anyway
        if (tank.isTop && tank.isStock) {
            [selectStockOrTop setSelectedSegmentIndex:1];
            [selectStockOrTop setEnabled:NO];
        } else if (tank.isTop) {
            // If all values are top, set that segment as highlighted
            [selectStockOrTop setSelectedSegmentIndex:1];
        } else if (tank.isStock) {
            // Same with the stock values
            [selectStockOrTop setSelectedSegmentIndex:0];
        } else {
            // If the modules are mixed (some stock, some top, and/or some in between)
            // then remove the highlights from all segments
            [selectStockOrTop setSelectedSegmentIndex:-1];
        }

        [self addSubview:selectStockOrTop];
        
        // Segmented control for setting the shell type
        NSArray *shellTypes = tank.gun.stringShellArray;
        UISegmentedControl *selectShellType = [[UISegmentedControl alloc] initWithItems:shellTypes];
        selectShellType.frame = CGRectMake(65, 40, 185, 30);
        [selectShellType setTintColor:format.darkColor];
        // Add the target
        [selectShellType addTarget:self
                            action:@selector(selectShellType:)
                  forControlEvents:UIControlEventValueChanged];
        // Check for the currently selected shell type and set the highlighted segment
        if (tank.gun.round.shellType == ShellTypeNormal) {
            [selectShellType setSelectedSegmentIndex:0];
        } else if (tank.gun.round.shellType == ShellTypeGold) {
            [selectShellType setSelectedSegmentIndex:1];
        } else if (tank.gun.round.shellType == ShellTypeHE) {
            [selectShellType setSelectedSegmentIndex:2];
        } else {
            [selectShellType setSelectedSegmentIndex:-1];
        }
        [self addSubview:selectShellType];
    }
    return self;
}

- (void)selectStockOrTop:(UISegmentedControl *)stockOrTop
{
    switch ([stockOrTop selectedSegmentIndex]) {
        case 0:
            [tank setAllValuesStock];
            [self.tankViewController viewDidLoad];
            break;
        case 1:
            [tank setAllValuesTop];
            [self.tankViewController viewDidLoad];
        default:
            break;
    }
}

- (void)selectShellType:(UISegmentedControl *)shellType
{
    switch ([shellType selectedSegmentIndex]) {
        case 0:
            [tank.gun setNormalRounds];
            [self.tankViewController viewDidLoad];
            break;
        case 1:
            [tank.gun setGoldRounds];
            [self.tankViewController viewDidLoad];
            break;
        case 2:
            [tank.gun setHERounds];
            [self.tankViewController viewDidLoad];
        default:
            break;
    }
}

@end
















