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
}

@property (nonatomic) Tank *tank;

- (void)renderHeader;

@end
