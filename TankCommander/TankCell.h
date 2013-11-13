//
//  TankCell.h
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TankCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tankImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tankTypeLabel;
//@property (weak, nonatomic) UITableView *tableView;


@end
