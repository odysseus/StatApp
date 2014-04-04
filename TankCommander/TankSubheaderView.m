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
#import "TankIPadViewController.h"

@implementation TankSubheaderView

@synthesize tankViewController;

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
        [format addButtonWithTarget:format
                           selector:@selector(fullscreenPopupFromButton:)
                    andControlEvent:UIControlEventTouchUpInside
                     withButtonData:@"hitpoints" toView:self
                          withFrame:CGRectMake(format.columnOneXLabel, y, format.labelWidth, format.labelHeight) text:@"Hitpoints"
                           fontSize:format.fontSize
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
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
                     withFrame:CGRectMake((format.columnTwoXLabel-20), y, format.labelWidth, format.labelHeight)
                          text:NSLocalizedString(@"Weight/Limit:", nil)
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        UILabel *loadLimit = [format addLabelToView:self
                     withFrame:CGRectMake((format.columnTwoXValue-20), y, format.labelWidth, format.valueHeight)
                          text:[NSString stringWithFormat:@"%0.2f/%0.2f", tank.weight, tank.loadLimit]
                      fontSize:format.fontSize
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        // Conditional to set the color of the vehicle weight if the modules weigh more than the
        // suspension can take
        if (tank.weight > tank.loadLimit) {
            [loadLimit setTextColor:[UIColor redColor]];
        } else {
            [loadLimit setTextColor:format.darkGreenColor];
        }
        
        // Row 1, Column 3
        [format addButtonWithTarget:format
                           selector:@selector(fullscreenPopupFromButton:)
                    andControlEvent:UIControlEventTouchUpInside
                     withButtonData:@"howTo"
                             toView:self
                          withFrame:CGRectMake(format.columnThreeXLabel, y, format.labelWidth, format.labelHeight)
                               text:@"Help"
                           fontSize:format.fontSize
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
    }

    
    
    return self;
}


@end
