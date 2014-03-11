//
//  RCToolTips.m
//  TankCommander
//
//  Created by Ryan Case on 3/10/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "RCToolTips.h"

@implementation RCToolTips

@synthesize toolTips;

+ (RCToolTips *)store
{
    static RCToolTips *singleton = nil;
    
    if (nil == singleton) {
        singleton = [[[self class] alloc] init];
        
        // Fetch the file path for the tooltips file
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tooltips" ofType:@"json"];
        // Grab the data
        NSData *data = [NSData dataWithContentsOfFile:path];
        // Parse the JSON into a JSON object, the type is id because it can return either an
        // array or a dictionary, but in this case we know it's a dictionary
        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        // Convert it into a dictionary
        singleton->toolTips = [json objectForKey:@"tooltips"];
        
    }
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"RCToolTips init");
    }
    return self;
}

- (NSArray *)valuesForKey:(NSString *)key
{
    NSArray *final = [toolTips valueForKey:key];
    return final;
}

@end














