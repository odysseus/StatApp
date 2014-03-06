//
//  RadioView.h
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tank, TankIPadViewController;

@interface RadioView : UIView
{
    Tank *tank;
}

@property (nonatomic) TankIPadViewController *tankViewController;

- (id)initWithOrigin:(CGPoint)point andTank:(Tank *)t;

@end
