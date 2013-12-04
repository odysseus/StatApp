//
//  RCFormatVariables.m
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "RCFormatting.h"
#import "TankViewController.h"
#import "ModulesViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation RCFormatting

@synthesize fontSize, darkColor, lightColor, barColor, debugGreen, debugBlue, debugPurple, columnOneXLabel,
columnOneXValue, columnTwoXLabel, columnTwoXValue, columnThreeXLabel, columnThreeXValue, labelHeight, labelWidth,
valueHeight, valueWidth, rowHeight, darkGreenColor;

+ (RCFormatting *)store
{
    // the instance of this class is stored here
    static RCFormatting *singleton = nil;
    
    // check to see if an instance already exists
    if (nil == singleton) {
        singleton  = [[[self class] alloc] init];
        // initialize variables here
        
        // Variables to provide consistent layout and colors
        singleton->fontSize = 16.0;
        singleton->darkColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
        singleton->lightColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
        singleton->barColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
        singleton->darkGreenColor = [UIColor colorWithRed:0.5 green:0.7 blue:0.5 alpha:1.0];
        
        // Debugging Colors to show the outlines of the different views
        singleton->debugGreen = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:0.8];
        singleton->debugBlue = [UIColor colorWithRed:0.9 green:0.9 blue:1.0 alpha:0.8];
        singleton->debugPurple = [UIColor colorWithRed:0.9 green:0.8 blue:1.0 alpha:0.8];
        
        // Setting column values
        singleton->columnOneXLabel = 20;
        singleton->columnOneXValue = 150;
        singleton->columnTwoXLabel = 260;
        singleton->columnTwoXValue = 390;
        singleton->columnThreeXLabel = 500;
        singleton->columnThreeXValue = 630;
        
        // Setting the size constraints
        singleton->labelWidth = 120;
        singleton->labelHeight = 24;
        singleton->valueWidth = 80;
        singleton->valueHeight = 24;
        
        // Row height to use when incrementing view height
        singleton->rowHeight = 45;
        
    }
    // return the instance of this class
    return singleton;
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
    
    [view addSubview:label];
    return label;
}

- (UIButton *)addButtonToView:(UIView *)view
                    withFrame:(CGRect)frame
                         text:(NSString *)text
                     fontSize:(CGFloat)size
                    fontColor:(UIColor *)color
          andContentAlignment:(UIControlContentHorizontalAlignment)alignment
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:size]];
    [button setContentHorizontalAlignment:alignment];
    
    [view addSubview:button];
    
    return button;
}

- (UIButton *)addButtonWithTarget:(id)target
                         selector:(SEL)selector
                  andControlEvent:(UIControlEvents)events
                           toView:(UIView *)view
                        withFrame:(CGRect)frame
                             text:(NSString *)text
                         fontSize:(CGFloat)size
                        fontColor:(UIColor *)color
              andContentAlignment:(UIControlContentHorizontalAlignment)alignment
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:size]];
    [button setContentHorizontalAlignment:alignment];
    
    [view addSubview:button];
    
    [button addTarget:target action:selector forControlEvents:events];
    
    return button;
}

-(void)fullscreenPopupFromView:(UIView *)view
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *fullscreen = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [fullscreen setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3]];
    [view.superview.superview addSubview:fullscreen];
    [view bringSubviewToFront:fullscreen];
    [fullscreen addTarget:fullscreen
                   action:@selector(removeFromSuperview)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *textView = [[UIView alloc] init];
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize popupSize = CGSizeMake(400, 300);
    CGPoint popupOrigin = CGPointMake(((bounds.size.width - popupSize.width) / 2), 200);
    [textView setFrame:CGRectMake(popupOrigin.x, popupOrigin.y, popupSize.width, popupSize.height)];
    [textView setBackgroundColor:[UIColor whiteColor]];
    textView.layer.cornerRadius = 10;
    textView.layer.masksToBounds = YES;
    [fullscreen addSubview:textView];
    
    [self addLabelToView:textView
               withFrame:CGRectMake(50, 20, 300, 30)
                    text:@"Penetration"
                fontSize:(self.fontSize * 1.5)
               fontColor:self.darkColor
        andTextAlignment:NSTextAlignmentCenter];
    
    UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(50, 60, 300, 200)];
    [textField setText:@"The amount of armor, in mm, that the shell can penetrate"];
    [textField setFont:[UIFont systemFontOfSize:self.fontSize]];
    [textField setTextColor:self.darkColor];
    [textView addSubview:textField];
}

@end
