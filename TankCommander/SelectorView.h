//
//  SelectorView.h
//  TankCommander
//
//  Created by Ryan Case on 11/18/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, TankIPadViewController;

@interface SelectorView : UIView
{
    Tank *tank;
}

@property (nonatomic, weak) UIViewController *tankViewController;

- (id)initForIPadWithOrigin:(CGPoint)origin andTank:(Tank *)tank;
- (id)initForIPhoneWithOrigin:(CGPoint)point andTank:(Tank *)t;
- (void)selectStockOrTop:(UISegmentedControl *)stockOrTop;
- (void)selectShellType:(UISegmentedControl *)shellType;

@end
