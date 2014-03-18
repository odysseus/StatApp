//
//  RadioView.m
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "RadioView.h"
#import "Tank.h"
#import "AverageTank.h"
#import "Radio.h"
#import "RCFormatting.h"
#import "TankIPadViewController.h"
#import "ModulesViewController.h"

@implementation RadioView

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
        
        [format addButtonWithTarget:self
                           selector:@selector(pushModulesViewController)
                    andControlEvent:UIControlEventTouchUpInside
                             toView:self
                          withFrame:CGRectMake(20, 10, 600, 28)
                               text:[NSString stringWithFormat:@"Radio: %@", tank.radio.name]
                           fontSize:(format.fontSize * 1.5)
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(680, 10, 40, 28)
                          text:romanStringFromInt(tank.radio.tier)
                      fontSize:(format.fontSize * 1.5)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentRight];
        
        // Row 1, Column 1
        [format addButtonWithTarget:format
                           selector:@selector(fullscreenPopupFromButton:)
                    andControlEvent:UIControlEventTouchUpInside
                     withButtonData:@"signalRange"
                             toView:self
                          withFrame:CGRectMake(format.columnOneXLabel, y, format.labelWidth, format.labelHeight)
                               text:@"Signal Range:"
                           fontSize:format.fontSize
                          fontColor:format.darkColor
                andContentAlignment:UIControlContentHorizontalAlignmentLeft];
        
        [format addLabelToView:self
                     withFrame:CGRectMake(format.columnOneXValue, y, 80, 24)
                          text:[NSString stringWithFormat:@"%0.0f", tank.signalRange]
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
                          text:[NSString stringWithFormat:@"%0.0f", tank.averageTank.signalRange]
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
    ModulesViewController *mvc = [[ModulesViewController alloc] initWithTank:tank andKey:@"availableRadios"];
    [mvc setTankViewController:tankViewController];
    [tankViewController.navigationController pushViewController:mvc animated:YES];
}

@end
