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
#import "TanksViewController.h"
#import "TiersViewController.h"
#import "TankIPadViewController.h"

@implementation RCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // [TankStore allTanks] inits the singleton store and kicks off the init waterfall that inits and loads all
    // the tanks and their attached modules
    TankStore *allTanks = [TankStore allTanks];
    if (allTanks) {
        NSLog(@"Tanks loaded");
    }
    
    // BEGIN DEBUGGING/LOGGING
    // END DEBUGGING/LOGGING
    
    // MAIN EXECUTION
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // The tiers view controller is the root for displaying all the tanks
    TiersViewController *tvc = [[TiersViewController alloc] init];
    
    // Init a nav controller with the tiers view controller
    UINavigationController *navController =  [[UINavigationController alloc] initWithRootViewController:tvc];
    // And set it as the RVC
    [[self window] setRootViewController:navController];
    // Make it visible
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
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
