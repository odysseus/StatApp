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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameAndTypeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *tierValue;
@property (weak, nonatomic) IBOutlet UILabel *tankXpValue;
@property (weak, nonatomic) IBOutlet UILabel *tankCostValue;
@property (weak, nonatomic) IBOutlet UILabel *penetrationValue;
@property (weak, nonatomic) IBOutlet UILabel *penetrationAverage;
@property (weak, nonatomic) IBOutlet UILabel *damageValue;
@property (weak, nonatomic) IBOutlet UILabel *damageAverage;
@property (weak, nonatomic) IBOutlet UILabel *rateOfFireValue;
@property (weak, nonatomic) IBOutlet UILabel *rateOfFireAverage;
@property (weak, nonatomic) IBOutlet UILabel *damagePerMinuteValue;
@property (weak, nonatomic) IBOutlet UILabel *damagePerMinuteAverage;
@property (weak, nonatomic) IBOutlet UILabel *aimTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *aimTimeAverage;
@property (weak, nonatomic) IBOutlet UILabel *accuracyValue;
@property (weak, nonatomic) IBOutlet UILabel *accuracyAverage;
@property (weak, nonatomic) IBOutlet UILabel *depressionValue;
@property (weak, nonatomic) IBOutlet UILabel *depressionAverage;
@property (weak, nonatomic) IBOutlet UILabel *elevationValue;
@property (weak, nonatomic) IBOutlet UILabel *elevationAverage;
@property (weak, nonatomic) IBOutlet UILabel *gunName;
@property (weak, nonatomic) IBOutlet UILabel *gunTier;


@end
