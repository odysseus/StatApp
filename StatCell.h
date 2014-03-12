//
//  StatCell.h
//  TankCommander
//
//  Created by Ryan Case on 3/7/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *stat;
@property (weak, nonatomic) IBOutlet UILabel *statValue;
@property (weak, nonatomic) IBOutlet UILabel *statAverage;
@property (nonatomic) NSString *dataString;

@end
