//
//  Shell.h
//  TankCommander
//
//  Created by Ryan Case on 10/21/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shell : NSObject

typedef enum ShellType : NSUInteger {
    ShellTypeNormal,
    ShellTypeGold,
    ShellTypeHE
} ShellType;

typedef enum Currency : NSUInteger {
    CurrencyTypeSilver,
    CurrencyTypeGold
} Currency;

@property ShellType shellType;
@property (nonatomic) float penetration;
@property (nonatomic) float damage;
@property (nonatomic) float cost;
@property (nonatomic) Currency shellCurrency;

- (id)initWithShellIndex:(int)index andArray:(NSArray *)arr;
ShellType fetchShellType (int index);

@end
