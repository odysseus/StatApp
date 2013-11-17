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
    CGFloat y = 45;
    self = [self initWithFrame:CGRectMake(point.x, point.y, screenWidth, y)];
    
    if (self) {
        tank = t;
        RCFormatting *format = [RCFormatting store];
                
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 700, 2)];
        [barView setBackgroundColor:format.barColor];
        [self addSubview:barView];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(20, 10, 400, 28)
                          text:[NSString stringWithFormat:@"Suspension and Hull"]
                      fontSize:(format.fontSize * 1.5)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(680, 10, 40, 28)
                          text:romanStringFromInt(tank.suspension.tier)
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
        y += 45;
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Effective Frontal:", nil)
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
        
        // Row 3, Column 1
        y += 45;
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
                          text:NSLocalizedString(@"Tread Traverse:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%d", tank.suspension.traverseSpeed]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y+15, 80, 24)
                          text:[NSString stringWithFormat:@"%d", tank.averageTank.hullTraverse]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        if (!tank.hasTurret) {
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
            
//            // Row 4, Column 1
//            y += 45;
//            [format addLabelToView:self
//                         withFrame:CGRectMake(format.columnOneXLabel, y, 120, 24)
//                              text:NSLocalizedString(@"Drum Capacity:", nil)
//                          fontSize:format.fontSize
//                         fontColor:format.darkColor
//                  andTextAlignment:NSTextAlignmentLeft];
//            [format addLabelToView:self
//                         withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
//                              text:[NSString stringWithFormat:@"%0.0f", tank.roundsInDrum]
//                          fontSize:format.fontSize
//                         fontColor:format.darkColor
//                  andTextAlignment:NSTextAlignmentLeft];
//            
//            // Row 4, Column 2
//            [format addLabelToView:self
//                         withFrame:CGRectMake(format.columnTwoXLabel, y, 120, 24)
//                              text:NSLocalizedString(@"Between Shots:", nil)
//                          fontSize:format.fontSize
//                         fontColor:format.darkColor
//                  andTextAlignment:NSTextAlignmentLeft];
//            [format addLabelToView:self
//                         withFrame:CGRectMake(format.columnTwoXValue, y, 80, 24)
//                              text:[NSString stringWithFormat:@"%0.2fs", tank.timeBetweenShots]
//                          fontSize:format.fontSize
//                         fontColor:format.darkColor
//                  andTextAlignment:NSTextAlignmentLeft];
//            
//            // Row 4, Column 3
//            [format addLabelToView:self
//                         withFrame:CGRectMake(format.columnThreeXLabel, y, 120, 24)
//                              text:NSLocalizedString(@"Full Reload:", nil)
//                          fontSize:format.fontSize
//                         fontColor:format.darkColor
//                  andTextAlignment:NSTextAlignmentLeft];
//            [format addLabelToView:self
//                         withFrame:CGRectMake(format.columnThreeXValue, y, 80, 24)
//                              text:[NSString stringWithFormat:@"%0.0fs", tank.drumReload]
//                          fontSize:format.fontSize
//                         fontColor:format.darkColor
//                  andTextAlignment:NSTextAlignmentLeft];
        }
        y += 45;
        self.frame = CGRectMake(point.x, point.y, screenWidth, y);
    }
    return self;
}

@end
