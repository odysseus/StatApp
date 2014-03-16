//
//  CompareiPadTableViewCell.m
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "CompareiPadTableViewCell.h"
#import "RCFormatting.h"

@implementation CompareiPadTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        RCFormatting *format = [RCFormatting store];
        // Initialization code
        [self.statName setTextColor:format.darkColor];
        [self.tankOneValue setTextColor:format.darkColor];
        [self.tankTwoValue setTextColor:format.darkColor];
        [self.averageValue setTextColor:format.lightColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
