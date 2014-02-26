//
//  HullView.m
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "HullView.h"
#import "Tank.h"
#import "AverageTank.h"
#import "RCFormatting.h"
#import "Suspension.h"
#import "Hull.h"

@implementation HullView

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
        
        [format addLabelToView:self
                     withFrame:CGRectMake(20, 10, 600, 28)
                          text:[NSString stringWithFormat:@"Hull: %@", tank.name]
                      fontSize:(format.fontSize * 1.5)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(680, 10, 40, 28)
                          text:romanStringFromInt(tank.tier)
                      fontSize:(format.fontSize * 1.5)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentRight];
        
        // Row 1, Column 1
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Frontal Hull:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.frontalHullArmor]
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
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.frontalHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 1, Column 2
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Side Hull:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.sideHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.sideHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 1, Column 3
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Rear Hull:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.rearHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.rearHullArmor]
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
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.effectiveFrontalHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.effectiveFrontalHullArmor]
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
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.effectiveSideHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.effectiveSideHullArmor]
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
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.effectiveRearHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0fmm", tank.averageTank.effectiveRearHullArmor]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        if (!tank.hasTurret) {
            // Row 3, Column 1
            y += format.rowHeight;
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                              text:NSLocalizedString(@"View Range:", nil)
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.viewRange]
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnOneXValue, y+15, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.averageTank.viewRange]
                          fontSize:format.fontSize
                         fontColor:format.lightColor
                  andTextAlignment:NSTextAlignmentLeft];
            
            // Row 3, Column 2
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnTwoXLabel, y, 120, 24)
                              text:NSLocalizedString(@"Gun Arc:", nil)
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnTwoXValue, y, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.gunTraverseArc]
                          fontSize:format.fontSize
                         fontColor:format.darkColor
                  andTextAlignment:NSTextAlignmentLeft];
            [format addLabelToView:self
                         withFrame:CGRectMake(format.columnTwoXValue, y+15, 80, 24)
                              text:[NSString stringWithFormat:@"%0.0f", tank.averageTank.gunTraverseArc]
                          fontSize:format.fontSize
                         fontColor:format.lightColor
                  andTextAlignment:NSTextAlignmentLeft];
        }
        y += format.rowHeight;
        self.frame = CGRectMake(point.x, point.y, screenWidth, y);
    }
    return self;
}

@end
