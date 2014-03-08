//
//  StatCell.m
//  TankCommander
//
//  Created by Ryan Case on 3/7/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "StatCell.h"

@implementation StatCell

@synthesize stat, statAverage, statValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
