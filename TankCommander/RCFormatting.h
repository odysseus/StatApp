//
//  RCFormatVariables.h
//  TankCommander
//
//  Created by Ryan Case on 11/17/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TankIPadViewController, Tank, RCButton;

@interface RCFormatting : NSObject

@property (nonatomic, readonly) CGFloat screenWidth;
@property (nonatomic, readonly) CGFloat screenHeight;

@property (nonatomic, readonly) CGFloat fontSize;
@property (nonatomic, readonly) UIColor *lightColor;
@property (nonatomic, readonly) UIColor *darkColor;
@property (nonatomic, readonly) UIColor *barColor;
@property (nonatomic, readonly) UIColor *darkGreenColor;

@property (nonatomic, readonly) UIColor *debugGreen;
@property (nonatomic, readonly) UIColor *debugBlue;
@property (nonatomic, readonly) UIColor *debugPurple;

@property (nonatomic, readonly) UIColor *highlightGreen;
@property (nonatomic, readonly) UIColor *highlightRed;
@property (nonatomic, readonly) UIColor *highlightYellow;

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
- (UIButton *)addButtonToView:(UIView *)view
                    withFrame:(CGRect)frame
                         text:(NSString *)text
                     fontSize:(CGFloat)size
                    fontColor:(UIColor *)color
          andContentAlignment:(UIControlContentHorizontalAlignment)alignment;
- (RCButton *)addButtonWithTarget:(id)target
                         selector:(SEL)selector
                  andControlEvent:(UIControlEvents)events
                           toView:(UIView *)view
                        withFrame:(CGRect)frame
                             text:(NSString *)text
                         fontSize:(CGFloat)size
                        fontColor:(UIColor *)color
              andContentAlignment:(UIControlContentHorizontalAlignment)alignment;
- (RCButton *)addButtonWithTarget:(id)target
                         selector:(SEL)selector
                  andControlEvent:(UIControlEvents)events
                   withButtonData:(NSString *)buttonData
                           toView:(UIView *)view
                        withFrame:(CGRect)frame
                             text:(NSString *)text
                         fontSize:(CGFloat)size
                        fontColor:(UIColor *)color
              andContentAlignment:(UIControlContentHorizontalAlignment)alignment;
- (void)fullscreenPopupFromButton:(id)sender;


@end
