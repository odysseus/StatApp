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
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    TankStore *allTanks = [TankStore allTanks];
    [allTanks loadTanks];
    
    Tank *heavy = [allTanks.tier8.heavyTanks findTankByName:@"FCM 50 t"];
    
    NSLog(@"\n\n%@\nWeight: %0.2f metric tons\nSpecific Power: %0.2f hp/ton\nDamage Per Minute: %0.0f\nReload Time: %0.2fs\n",
          heavy, heavy.weight, heavy.specificPower, heavy.damagePerMinute, heavy.reloadTime);
    
    Tank *medium = [allTanks.tier8.mediumTanks findTankByName:@"Type 59"];
    
    NSLog(@"\n\n%@\nWeight: %0.2f metric tons\nSpecific Power: %0.2f hp/ton\nDamage Per Minute: %0.0f\nReload Time: %0.2fs\n",
          medium, medium.weight, medium.specificPower, medium.damagePerMinute, medium.reloadTime);
    
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
