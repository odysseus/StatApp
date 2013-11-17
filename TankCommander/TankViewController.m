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
#import "GunView.h"

@interface TankViewController ()

@end

@implementation TankViewController

@synthesize tank;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Variables to provide consistent layout and colors
        fontSize = 16.0;
        darkColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        lightColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
        barColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
        
        // Debugging Colors to show the outlines of the different views
        debugGreen = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:0.8];
        debugBlue = [UIColor colorWithRed:0.9 green:0.9 blue:1.0 alpha:0.8];
        debugPurple = [UIColor colorWithRed:0.9 green:0.8 blue:1.0 alpha:0.8];
        
        // Setting column values
        columnOneXLabel = 20;
        columnOneXValue = 150;
        columnTwoXLabel = 260;
        columnTwoXValue = 390;
        columnThreeXLabel = 500;
        columnThreeXValue = 630;
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
    
    CGPoint origin = CGPointMake(0, 0);
    
    UIView *headerView = [self renderHeaderFromPoint:origin];
    [self.view addSubview:headerView];
    // Advance the Y value on the origin point so that subsequent views render from the right spot
    origin.y += headerView.frame.size.height;
    
    UIView *subheader = [self renderSubheaderFromPoint:origin];
    [self.view addSubview:subheader];
    origin.y += subheader.frame.size.height;
    
    GunView *gunView = [[GunView alloc] initWithOrigin:origin andTank:tank];
    [self.view addSubview:gunView];
    origin.y += gunView.frame.size.height;
    
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

- (UIView *)renderHeaderFromPoint:(CGPoint)point
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(point.x,
                                                                  point.y,
                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                  60)];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    // Tank Type Image
    UIImageView *tankClassImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    [tankClassImage setImage:tank.imageForTankType];
    [headerView addSubview:tankClassImage];
    
    // Tank Name
    [self addLabelToView:headerView
               withFrame:CGRectMake(60, 0, 360, 50)
                    text:tank.name
                fontSize:(fontSize * 2)
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    
    // Tank Nationality and Type
    [self addLabelToView:headerView
               withFrame:CGRectMake(60, 40, 360, 20)
                    text:tank.stringNationalityAndType
                fontSize:fontSize
               fontColor:lightColor
        andTextAlignment:NSTextAlignmentLeft];
    
    // Experience fields will only show on non-premium tanks
    if (!tank.premiumTank) {
        // Experience Needed Label
        [self addLabelToView:headerView
                   withFrame:CGRectMake(565, 10, 40, 20)
                        text:NSLocalizedString(@"XP:", nil)
                    fontSize:(fontSize * 0.75)
                   fontColor:lightColor
            andTextAlignment:NSTextAlignmentLeft];
        
        [numberFormatter stringFromNumber:[NSNumber numberWithInteger:tank.experienceNeeded]];
        // Experience Needed Value
        [self addLabelToView:headerView
                   withFrame:CGRectMake(615, 10, 75, 20)
                        text:[numberFormatter stringFromNumber:[NSNumber numberWithInteger:tank.experienceNeeded]]
                    fontSize:(fontSize * 0.75)
                   fontColor:lightColor
            andTextAlignment:NSTextAlignmentLeft];
    }
    
    // Cost label
    [self addLabelToView:headerView
               withFrame:CGRectMake(565, 30, 40, 20)
                    text:NSLocalizedString(@"Cost:", nil)
                fontSize:(fontSize * 0.75)
               fontColor:lightColor
        andTextAlignment:NSTextAlignmentLeft];
    
    // Cost value (Capturing the pointer to conditionally set the color of the cost)
    UILabel *costValue = [self addLabelToView:headerView
                                    withFrame:CGRectMake(615, 30, 75, 20)
                                         text:[numberFormatter stringFromNumber:
                                               [NSNumber numberWithInteger:tank.cost]]
                                     fontSize:(fontSize * 0.75)
                                    fontColor:lightColor
                             andTextAlignment:NSTextAlignmentLeft];
    
    // Display cost differently if the tank is a premium
    if (tank.premiumTank) {
        [costValue setTextColor:[UIColor orangeColor]];
    }
    
    // Tank Tier as a Roman Numeral
    [self addLabelToView:headerView
               withFrame:CGRectMake(700, 0, 50, 60)
                    text:romanStringFromInt(tank.tier)
                fontSize:(fontSize * 2)
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    
    return headerView;
}

- (UIView *)renderSubheaderFromPoint:(CGPoint)point
{
    UIView *subheader = [[UIView alloc] initWithFrame:CGRectMake(point.x,
                                                                 point.y,
                                                                 [UIScreen mainScreen].bounds.size.width,
                                                                 70)];
    CGFloat y = 20;
    
    // Row 1, Column 1
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnOneXLabel, y, 120, 24)
                    text:NSLocalizedString(@"Hitpoints:", nil)
                fontSize:fontSize
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnOneXValue, y, 80, 24)
                    text:[NSString stringWithFormat:@"%d", tank.hitpoints]
                fontSize:fontSize
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnOneXLabel, y+15, 120, 24)
                    text:NSLocalizedString(@"Average:", nil)
                fontSize:fontSize
               fontColor:lightColor
        andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnOneXValue, y+15, 80, 24)
                    text:[NSString stringWithFormat:@"%d", tank.averageTank.hitpoints]
                fontSize:fontSize
               fontColor:lightColor
        andTextAlignment:NSTextAlignmentLeft];
    
    // Row 1, Column 2
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnTwoXLabel, y, 120, 24)
                    text:NSLocalizedString(@"Specific Power:", nil)
                fontSize:fontSize
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnTwoXValue, y, 80, 24)
                    text:[NSString stringWithFormat:@"%0.2f", tank.specificPower]
                fontSize:fontSize
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnTwoXValue, y+15, 80, 24)
                    text:[NSString stringWithFormat:@"%0.2f", tank.averageTank.specificPower]
                fontSize:fontSize
               fontColor:lightColor
        andTextAlignment:NSTextAlignmentLeft];
    
    // Row 1, Column 3
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnThreeXLabel, y, 120, 24)
                    text:NSLocalizedString(@"Camo Value:", nil)
                fontSize:fontSize
               fontColor:darkColor
        andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnThreeXValue, y, 80, 24)
                    text:[NSString stringWithFormat:@"%0.2f", tank.camoValue]
                fontSize:fontSize
               fontColor:darkColor andTextAlignment:NSTextAlignmentLeft];
    [self addLabelToView:subheader
               withFrame:CGRectMake(columnThreeXValue, y+15, 80, 24)
                    text:[NSString stringWithFormat:@"%0.2f", tank.averageTank.camoValue]
                fontSize:fontSize
               fontColor:lightColor
        andTextAlignment:NSTextAlignmentLeft];
    
    return subheader;
}

@end













