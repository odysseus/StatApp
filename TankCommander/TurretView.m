//
//  TurretView.m
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TurretView.h"
#import "RCFormatting.h"
#import "Tank.h"
#import "AverageTank.h"
#import "Turret.h"
#import "ModulesViewController.h"
#import "TankViewController.h"

@implementation TurretView

@synthesize tankViewController;

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
    RCFormatting *format = [RCFormatting store];

    CGFloat y = format.rowHeight;
    self = [self initWithFrame:CGRectMake(point.x, point.y, screenWidth, y)];
    
    if (self) {
        tank = t;
        
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 700, 2)];
        [barView setBackgroundColor:format.barColor];
        [self addSubview:barView];
        
        UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        nameButton.frame = CGRectMake(20, 10, 600, 28);
        [nameButton setTitle:[NSString stringWithFormat:@"Turret: %@", tank.turret.name]
                    forState:UIControlStateNormal];
        [nameButton setTitle:[NSString stringWithFormat:@"Turret: %@", tank.turret.name]
                    forState:UIControlStateNormal];
        [nameButton setTitleColor:format.darkColor
                         forState:UIControlStateNormal];
        [nameButton setTitleColor:format.lightColor
                         forState:UIControlStateHighlighted];
        [nameButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [[nameButton titleLabel] setFont:[UIFont systemFontOfSize:(format.fontSize * 1.5)]];
        [[nameButton titleLabel] setTextAlignment:NSTextAlignmentLeft];
        [nameButton addTarget:self
                       action:@selector(pushModulesViewController)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nameButton];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(680, 10, 40, 28)
                          text:romanStringFromInt(tank.turret.tier)
                      fontSize:(format.fontSize * 1.5)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentRight];
        
        // Row 1, Column 1
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Frontal Turret:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.frontalTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y+15, 120, 24)
                          text:NSLocalizedString(@"Average:", nil)
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.frontalTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 1, Column 2
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Side Turret:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.sideTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.sideTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 1, Column 3
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Rear Turret:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.rearTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.rearTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 2, Column 1
        y += format.rowHeight;
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Effective Front:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.effectiveFrontalTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.effectiveFrontalTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 2, Column 2
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Effective Side:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.effectiveSideTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.effectiveSideTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 2, Column 3
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Effective Rear:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.effectiveRearTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.effectiveRearTurretArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 3, Column 1
        y += format.rowHeight;
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Turret Traverse:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%d", tank.turretTraverse]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%d", tank.averageTank.turretTraverse]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
            // Row 3, Column 2
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnTwoXLabel, y, 120, 24)
                              text:NSLocalizedString(@"View Range:", nil)
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnTwoXValue, y, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.viewRange]
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnTwoXValue, y+15, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.averageTank.viewRange]
                          fontSize:format.fontSize
                         fontColor:format.lightColor
                  andTextAlignment:NSTextAlignmentLeft];
            
            // Row 3, Column 3
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnThreeXLabel, y, 120, 24)
                              text:NSLocalizedString(@"Gun Arc:", nil)
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnThreeXValue, y, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.gunTraverseArc]
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnThreeXValue, y+15, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.averageTank.gunTraverseArc]
                          fontSize:format.fontSize
                         fontColor:format.lightColor
                  andTextAlignment:NSTextAlignmentLeft];

        y += format.rowHeight;
        self.frame = CGRectMake(point.x, point.y, screenWidth, y);
    }
    return self;
}

- (void)pushModulesViewController
{
    ModulesViewController *mvc = [[ModulesViewController alloc] initWithTank:tank andKey:@"availableTurrets"];
    [mvc setTankViewController:tankViewController];
    [tankViewController.navigationController pushViewController:mvc animated:YES];
}

@end
