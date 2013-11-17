//
//  TankSubheaderView.m
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankSubheaderView.h"
#import "Tank.h"
#import "AverageTank.h"
#import "RCFormatting.h"

@implementation TankSubheaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPoint:(CGPoint)point andTank:(Tank *)t
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self = [self initWithFrame:CGRectMake(point.x, point.y, screenWidth, 70)];
    if (self) {
        tank = t;
        RCFormatting *format = [RCFormatting store];
        
        CGFloat y = 20;
        
        // Row 1, Column 1
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y, format.labelWidth, format.labelHeight)
                          text:NSLocalizedString(@"Hitpoints:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, format.valueWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%d", tank.hitpoints]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXLabel, y+15, format.labelWidth, format.labelHeight)
                          text:NSLocalizedString(@"Average:", nil)
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y+15, format.valueWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%d", tank.averageTank.hitpoints]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 1, Column 2
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXLabel, y, format.labelWidth, format.labelHeight)
                          text:NSLocalizedString(@"Specific Power:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y, format.valueWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%0.2f", tank.specificPower]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnTwoXValue, y+15, format.valueWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%0.2f", tank.averageTank.specificPower]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Row 1, Column 3
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXLabel, y, format.labelWidth, format.labelHeight)
                          text:NSLocalizedString(@"Camo Value:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y, format.valueWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%0.2f", tank.camoValue]
                      fontSize:format.fontSize
                     fontColor:format.darkColor andTextAlignment:NSTextAlignmentLeft];
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnThreeXValue, y+15, format.valueWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%0.2f", tank.averageTank.camoValue]
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
    }
    
    return self;
}


@end
