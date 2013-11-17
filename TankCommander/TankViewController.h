//
//  TankViewController.h
//  TankCommander
//
//  Created by Ryan Case on 11/12/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank;

@interface TankViewController : UIViewController
{
    CGFloat fontSize;
    UIColor *lightColor;
    UIColor *darkColor;
    UIColor *barColor;
    
    UIColor *debugGreen;
    UIColor *debugBlue;
    UIColor *debugPurple;
    
    CGFloat columnOneXLabel;
    CGFloat columnTwoXLabel;
    CGFloat columnThreeXLabel;
    
    CGFloat columnOneXValue;
    CGFloat columnTwoXValue;
    CGFloat columnThreeXValue;
}

@property (nonatomic) Tank *tank;

- (UILabel *)addLabelToView:(UIView *)view
                  withFrame:(CGRect)frame
                       text:(NSString *)text
                   fontSize:(CGFloat)size
                  fontColor:(UIColor *)color
           andTextAlignment:(NSTextAlignment)alignment;

// Rendering Methods
- (UIView *)renderHeaderFromPoint:(CGPoint)point;

@end
