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
#import "TankViewController.h"

@implementation RCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Debugging and Logging Code
    TankStore *allTanks = [TankStore allTanks];
    
    NSMutableArray *tier8 = allTanks.tier8.all.group;
    
    for (Tank *tank in tier8) {
        //
    }
    
    NSString *key = @"viewRange";
    NSString *range = @"all";
    NSString *tier = @"tier8";
    BOOL smallerIsBetter = NO;
    
    NSLog(@"Average %@ for %@ in %@: %@",
          key, range, tier, [[[allTanks valueForKey:tier] valueForKey:range] averageValueForKey:key]);
    
    NSString *list = [[[allTanks valueForKey:tier] valueForKey:range]
                      stringSortedListForKey:key
                      smallerValuesAreBetter:smallerIsBetter];
    NSLog(@"\n%@", list);
    
    //  ACTUAL METHOD
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TiersViewController *tvc = [[TiersViewController alloc] init];
    
    UINavigationController *navController =  [[UINavigationController alloc] initWithRootViewController:tvc];

    
//    TankViewController *tankVC = [[TankViewController alloc] init];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSArray *viewControllers = @[tvc, tankVC];
//        UISplitViewController *svc = [[UISplitViewController alloc] init];
//        [svc setDelegate:tvc];
//        [svc setViewControllers:viewControllers];
//        [[self window] setRootViewController:svc];
//    }
    
    [[self window] setRootViewController:navController];
    
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
