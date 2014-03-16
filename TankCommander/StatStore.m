//
//  StatStore.m
//  TankCommander
//
//  Created by Ryan Case on 3/15/14.
//  Copyright (c) 2014 Ryan Case. All rights reserved.
//

#import "StatStore.h"
#import "Stat.h"

@implementation StatStore

@synthesize stats;

+ (StatStore *)store
{
    static StatStore *singleton = nil;
    if (nil == singleton) {
        NSLog(@"StatStore init");
        singleton = [[[self class] alloc] init];
        
        // Fetch the file path for the tooltips file
        NSString *path = [[NSBundle mainBundle] pathForResource:@"attributes" ofType:@"json"];
        // Grab the data
        NSData *data = [NSData dataWithContentsOfFile:path];
        // Parse the JSON into a JSON object, the type is id because it can return either an
        // array or a dictionary, but in this case we know it's a dictionary
        id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        // Convert it into a dictionary
        NSDictionary *statHash = [json objectForKey:@"attributes"];
        
        NSMutableDictionary *final = [[NSMutableDictionary alloc] init];
        
        for (NSString *attKey in statHash) {
            Stat *s = [[Stat alloc] init];
            s.key = attKey;
            s.displayName = statHash[attKey][1];
            s.glossaryName = statHash[attKey][0];
            s.definition = statHash[attKey][3];
            s.value = [NSNumber numberWithFloat:0];
            if ([statHash[attKey][2] isEqualToString:@"float"]) {
                s.statType = FloatStat;
            } else {
                s.statType = IntStat;
            }
            [final setValue:s forKey:attKey];
        }
        singleton->stats = final;
    }
    return singleton;
}

- (Stat *)statForKey:(NSString *)key
{
    return [self.stats valueForKey:key];
}

@end













