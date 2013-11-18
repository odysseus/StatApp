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
#import "TankViewController.h"
#import "Gun.h"

@implementation SelectorView

@synthesize tankView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)point andTank:(Tank *)t
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self = [super initWithFrame:CGRectMake(point.x, point.y, screenWidth, 45)];
    
    if (self) {
        RCFormatting *format = [RCFormatting store];
        tank = t;
        
        NSArray *stockTop = @[@"Stock Values", @"Top Values"];
        UISegmentedControl *stockOrTop = [[UISegmentedControl alloc] initWithItems:stockTop];
        stockOrTop.frame = CGRectMake(291.5, 10, 185, 30);
        [stockOrTop setTintColor:format.darkColor];
        [stockOrTop addTarget:self
                       action:@selector(stockOrTopSegmentedControl:)
             forControlEvents:UIControlEventValueChanged];
        if (tank.isStock) {
            [stockOrTop setSelectedSegmentIndex:0];
        } else if (tank.isTop) {
            [stockOrTop setSelectedSegmentIndex:1];
        }
        if (tank.premiumTank) {
            [stockOrTop setEnabled:NO];
        }
        [self addSubview:stockOrTop];
    }
    return self;
}

- (void)stockOrTopSegmentedControl:(UISegmentedControl *)stockOrTop
{
    switch ([stockOrTop selectedSegmentIndex]) {
        case 0:
            [tank setAllValuesStock];
            [stockOrTop setSelectedSegmentIndex:0];
            [self.tankView viewDidLoad];
            break;
        case 1:
            [tank setAllValuesTop];
            [stockOrTop setSelectedSegmentIndex:1];
            [self.tankView viewDidLoad];
        default:
            break;
    }
}

@end
