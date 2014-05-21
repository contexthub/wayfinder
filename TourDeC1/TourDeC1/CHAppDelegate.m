//
//  CHAppDelegate.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHAppDelegate.h"
#import "ContextHub.h"
#import "CCHNotificationService.h"
#import "CHBeaconsRouteService.h"

@implementation CHAppDelegate
+ (CHAppDelegate *) sharedAppDelegate {
  return (CHAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Register for notifications
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Initialize ContextHub with our app ID
    [ContextHub registerWithAppId:@"76a53f7d-3984-4e5c-9fdc-be3941d2cd69"];
    
    // Set default number of times visited
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"timesVisited":@0}];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //This turns on background updates.
    [ContextHub application:application didReceiveRemoteNotification:userInfo completion:completionHandler];
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

#pragma mark - push notifications

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did fail to register for push %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    CCHNotificationService *sharedService = [CCHNotificationService sharedService];
    
    [sharedService registerDeviceToken:deviceToken withCompletion:^(NSError *error) {
    }];
}

@end
