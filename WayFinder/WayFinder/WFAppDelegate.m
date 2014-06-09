//
//  WFAppDelegate.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFAppDelegate.h"
#import <ContextHub/ContextHub.h>


@implementation WFAppDelegate
+ (WFAppDelegate *) sharedAppDelegate {
  return (WFAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Initialize ContextHub with our app ID
    [ContextHub registerWithAppId:@"4816b346-c944-4482-98e9-3dd1c566abc8"];
    
    // Subscribe to "beacondemo" beacon tag
    [[CCHSubscriptionService sharedService] addBeaconSubscriptionForTags:@[@"beacondemo"] completionHandler:^(NSError *error) {
        if (!error) {
            NSLog(@"Successfully subscribed to \"beacondemo\" beacon tag");
        } else {
            NSLog(@"Subscription failed");
        }
    }];
    
    // Set default number of times visited
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"timesVisited":@0}];
    
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
