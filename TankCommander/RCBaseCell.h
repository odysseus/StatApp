//
//  RCBaseCell.h
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBaseCell : UITableViewCell

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) id controller;

- (void)sendSelectorToController:(NSString *)selectorName
                      withParams:(NSArray *)params;

@end
