//
//  RCFormatVariables.h
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TankViewController, Tank;

@interface RCFormatting : NSObject

@property (nonatomic, readonly) CGFloat fontSize;
@property (nonatomic, readonly) UIColor *lightColor;
@property (nonatomic, readonly) UIColor *darkColor;
@property (nonatomic, readonly) UIColor *barColor;
@property (nonatomic, readonly) UIColor *darkGreenColor;

@property (nonatomic, readonly) UIColor *debugGreen;
@property (nonatomic, readonly) UIColor *debugBlue;
@property (nonatomic, readonly) UIColor *debugPurple;

@property (nonatomic, readonly) CGFloat columnOneXLabel;
@property (nonatomic, readonly) CGFloat columnTwoXLabel;
@property (nonatomic, readonly) CGFloat columnThreeXLabel;

@property (nonatomic, readonly) CGFloat columnOneXValue;
@property (nonatomic, readonly) CGFloat columnTwoXValue;
@property (nonatomic, readonly) CGFloat columnThreeXValue;

@property (nonatomic, readonly) CGFloat labelWidth;
@property (nonatomic, readonly) CGFloat labelHeight;
@property (nonatomic, readonly) CGFloat valueWidth;
@property (nonatomic, readonly) CGFloat valueHeight;

@property (nonatomic, readonly) CGFloat rowHeight;

+ (RCFormatting *)store;
- (UILabel *)addLabelToView:(UIView *)view
                  withFrame:(CGRect)frame
                       text:(NSString *)text
                   fontSize:(CGFloat)size
                  fontColor:(UIColor *)color
           andTextAlignment:(NSTextAlignment)alignment;
- (void)pushModulesViewControllerForTank:(Tank *)t
                                     key:(NSString *)key
                   andTankViewController:(TankViewController *)tvc;

@end
