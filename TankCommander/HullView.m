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
#import "TankIPadViewController.h"

@implementation HullView

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
        [format addButtonWithTarget:tankViewController
                           selector:@selector(fullscreenPopupFromButton:)
                    andControlEvent:UIControlEventTouchUpInside
                     withButtonData:@"frontalHullArmor"
                             toView:self
                          withFrame:CGRectMake(format.columnOneXLabel, y, format.labelWidth, format.labelHeight)
                               text:@"Frontal Hull:"
                           fontSize:format.fontSize
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
        
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
        [format addButtonWithTarget:tankViewController
                           selector:@selector(fullscreenPopupFromButton:)
                    andControlEvent:UIControlEventTouchUpInside
                     withButtonData:@"sideHullArmor"
                             toView:self
                          withFrame:CGRectMake(format.columnTwoXLabel, y, format.labelWidth, format.labelHeight)
                               text:@"Side Hull:"
                           fontSize:format.fontSize
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
        
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
        [format addButtonWithTarget:tankViewController
                           selector:@selector(fullscreenPopupFromButton:)
                    andControlEvent:UIControlEventTouchUpInside
                     withButtonData:@"rearHullArmor"
                             toView:self
                          withFrame:CGRectMake(format.columnThreeXLabel, y, format.labelWidth, format.labelHeight)
                               text:@"Rear Hull:"
                           fontSize:format.fontSize
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
        
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
        
        if (!tank.hasTurret) {
            // Row 2, Column 1
            y += format.rowHeight;

            [format addButtonWithTarget:tankViewController
                               selector:@selector(fullscreenPopupFromButton:)
                        andControlEvent:UIControlEventTouchUpInside
                         withButtonData:@"viewRange"
                                 toView:self
                              withFrame:CGRectMake(format.columnOneXLabel, y, format.labelWidth, format.labelHeight)
                                   text:@"View Range:"
                               fontSize:format.fontSize
                              fontColor:format.darkColor
                    andContentAlignment:UIControlContentHorizontalAlignmentLeft];
            
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
            [format addButtonWithTarget:tankViewController
                               selector:@selector(fullscreenPopupFromButton:)
                        andControlEvent:UIControlEventTouchUpInside
                         withButtonData:@"gunTraverseArc"
                                 toView:self
                              withFrame:CGRectMake(format.columnTwoXLabel, y, format.labelWidth, format.labelHeight)
                                   text:@"Gun Arc:"
                               fontSize:format.fontSize
                              fontColor:format.darkColor
                    andContentAlignment:UIControlContentHorizontalAlignmentLeft];
            
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
