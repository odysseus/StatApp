//
//  RCBaseCell.m
//  TankCommander
//
//  Created by Ryan Case on 11/11/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "RCBaseCell.h"

@implementation RCBaseCell

@synthesize tableView, controller;

- (void)sendSelectorToController:(NSString *)selectorName withParams:(NSArray *)params;
{
    // if no selector is called then ignore...
    if([self controller] == nil)
    {
        NSLog(@"sendSelectorToController  - Error : No controller set!");
        return;
    }
    
    SEL selector = NSSelectorFromString(selectorName);
    
    NSMethodSignature *signature;
    NSInvocation *invocation;
    
    signature = [[[self controller] class] instanceMethodSignatureForSelector:selector];
    if(signature == nil)
    {
        NSLog(@"sendSelectorToController  - Error : signature not found!");
        return;
    }
    invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:[self controller]];
    
    for (int i = 0; i < [params count]; i++) {
        id param = [params objectAtIndex:i];
        if(param != nil)
            [invocation setArgument:&param atIndex: i + 2];
    }
    [invocation invoke];
}

@end
