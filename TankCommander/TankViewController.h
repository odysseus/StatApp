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

@property (nonatomic) Tank *tank;
@property (weak, nonatomic) IBOutlet UIImageView *tankImage;
@property (weak, nonatomic) IBOutlet UILabel *tankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tankCountryLabel;

@end
