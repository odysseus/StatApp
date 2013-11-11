//
//  RCAppDelegate.m
//  TankCommander
//
//  Created by Ryan Case on 10/20/13.
//  Copyright (c) 2013 Ryan Case. All rights reserved.
//

#import "RCAppDelegate.h"
#import "Tank.h"
#import "Tier.h"
#import "TankStore.h"
#import "Gun.h"
#import "TankGroup.h"

@implementation RCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    TankStore *allTanks = [TankStore allTanks];
    
    NSMutableArray *tier8 = allTanks.tier8.all.group;
    
    for (Tank *tank in tier8) {
        [tank validate];
    }
    
    Tank *tank = [allTanks.tier8.all findTankByName:@"AMX 13 90"];
    NSLog(@"%@: %@", tank.name, tank.gun);
    
    NSString *key = @"effectiveFrontalHullArmor";
    NSString *range = @"all";
    NSString *tier = @"tier8";
    BOOL smallerIsBetter = NO;
    
    NSLog(@"Average %@ for %@ in %@: %@",
          key, range, tier, [[[allTanks valueForKey:tier] valueForKey:range] averageValueForKey:key]);
    
    NSString *list = [[[allTanks valueForKey:tier] valueForKey:range]
                      stringSortedListForKey:key
                      smallerValuesAreBetter:smallerIsBetter];
    NSLog(@"\n%@", list);

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
