//
//  Tankself.m
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "TankHeaderView.h"
#import "Tank.h"
#import "RCFormatting.h"

@implementation TankHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPoint:(CGPoint)point andTank:(Tank *)t
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self = [self initWithFrame:CGRectMake(point.x, point.y, screenWidth, 60)];
    if (self) {
        RCFormatting *format = [RCFormatting store];
        tank = t;
        
        // Number formatter to pretty-print the cost and XP numbers
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
        [numberFormatter setGroupingSize:3];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        // Tank Type Image
        UIImageView *tankClassImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [tankClassImage setImage:tank.imageForTankType];
        [self addSubview:tankClassImage];
        
        // Tank Name
        [format addLabelToView:self
                     withFrame:CGRectMake(60, 0, 400, 50)
                          text:tank.name
                      fontSize:(format.fontSize * 2)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // Tank Nationality and Type
        [format addLabelToView:self
                     withFrame:CGRectMake(60, 40, 360, 20)
                          text:tank.stringNationalityAndType
                      fontSize:format.fontSize
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentLeft];
        
        // No way to get XP needed without manually inputting it all, so this is commented out until
        // a better solution is found
        // Experience fields will only show on non-premium tanks
//        if (!tank.premiumTank) {
//            // Experience Needed Label
//            [format addLabelToView:self
//                         withFrame:CGRectMake(565, 10, 40, 20)
//                              text:NSLocalizedString(@"XP:", nil)
//                          fontSize:(format.fontSize * 0.75)
//                         fontColor:format.lightColor
//                  andTextAlignment:NSTextAlignmentRight];
//            
//            // Experience Needed Value
//            [format addLabelToView:self
//                         withFrame:CGRectMake(615, 10, 75, 20)
//                              text:[numberFormatter stringFromNumber:[NSNumber numberWithInteger:tank.experienceNeeded]]
//                          fontSize:(format.fontSize * 0.75)
//                         fontColor:format.lightColor
//                  andTextAlignment:NSTextAlignmentLeft];
//        }
        
        // Cost label
        [format addLabelToView:self
                     withFrame:CGRectMake(565, 30, 40, 20)
                          text:NSLocalizedString(@"Cost:", nil)
                      fontSize:(format.fontSize * 0.75)
                     fontColor:format.lightColor
              andTextAlignment:NSTextAlignmentRight];
        
        // Cost value (Capturing the pointer to conditionally set the color of the cost)
        UILabel *costValue = [format addLabelToView:self
                                          withFrame:CGRectMake(615, 30, 75, 20)
                                               text:[numberFormatter stringFromNumber:
                                                     [NSNumber numberWithInteger:tank.cost]]
                                           fontSize:(format.fontSize * 0.75)
                                          fontColor:format.lightColor
                                   andTextAlignment:NSTextAlignmentLeft];
        
        // If the tank is a premium, display the cost in gold
        if (tank.premiumTank) {
            [costValue setTextColor:[UIColor orangeColor]];
        }
        // But if the tank is premium and not available in the store, then set the
        // price color to blue
        if (!tank.available && tank.premiumTank) {
            [costValue setTextColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6]];
        }
        
        // Tank Tier as a Roman Numeral
        [format addLabelToView:self
                     withFrame:CGRectMake(700, 0, 50, 60)
                          text:romanStringFromInt(tank.tier)
                      fontSize:(format.fontSize * 2)
                     fontColor:format.darkColor
              andTextAlignment:NSTextAlignmentLeft];
    }
    return self;
}

@end
