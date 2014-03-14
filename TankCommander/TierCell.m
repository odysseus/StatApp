//
//  TierCell.m
//  TankCommander
//
//  Created by Ryan Case on 11/16/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TierCell.h"

@implementation TierCell

@synthesize tierLabel, tierRomanLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
