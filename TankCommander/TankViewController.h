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
    UIColor *debugGreen;
    UIColor *debugBlue;
    UIColor *debugPurple;
}

@property (nonatomic) Tank *tank;

- (UILabel *)addLabelToView:(UIView *)view
                  withFrame:(CGRect)frame
                       text:(NSString *)text
                   fontSize:(CGFloat)size
               andFontColor:(UIColor *)color;

// Rendering Methods
- (UIView *)renderHeaderFromPoint:(CGPoint)point;

@end
