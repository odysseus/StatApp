//
//  CompareiPadTableViewCell.h
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareiPadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statName;
@property (weak, nonatomic) IBOutlet UILabel *tankOneValue;
@property (weak, nonatomic) IBOutlet UILabel *tankTwoValue;
@property (weak, nonatomic) IBOutlet UILabel *averageValue;

@end
