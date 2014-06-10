//
//  CCHPush.h
//  ContextHub
//
//  Created by Travis Fischer on 9/26/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 The push service is used to register devices and to send push notifications with the ContextHub Push service.
 */
@interface CCHPush : NSObject


/**
 @ return The singleton instance of the CCHPush service.
 */
+ (id)sharedService;

/**
 * Register a device for push notifications.
 * @param token The device token.
 * @param alias (optional) A string alias to associate with the device token.
 * @param tags (optional) An array of tags to associate with the token.
 * @param completionHandler (optional) returns nil if succeeded otherwise includes an error object.
 */
- (void)registerDeviceToken:(id)token alias:(NSString *)alias tags:(NSArray *)tags completionHandler:(void(^)(NSError *error))completionHandler;

/**
 Send Push Notifications to devices.
 
 The userInfo dictionary can contain custom data and standard apple push notification properties.
 This implementation will pull out the apns keys and pass all other items as custom data.
 
 | key | value|
 | --- | --- |
 | alert | the message you want sent |
 | sound | sound you want played |
 | content-available | pass in a 1 if you want to deliver a push in the background |
 | badge | the number to be displayed on the icon |

  @param devices The device Id's to notify.
  @param userInfo Other data to be sent in the notification
  @param completionHandler Completion block.  If an error occurs an NSError will be passed to the block.
 */
- (void)sendNotificationToDevices:(NSArray *)devices userInfo:(NSDictionary *)userInfo completionHandler:(void (^)(NSError *error))completionHandler;


/**
 * Send Push Notification to aliases.
 *
 *
 * The userInfo dictionary can contain custom data and standard apple push notification properties.
 * This implementation will pull out the apns keys and pass all other items as custom data.
 *
 * | key | value|
 * | --- | --- |
 * | alert | the message you want sent |
 * | sound | the name of the sound file that you want to be played |
 * | content-available | pass in a 1 if you want to deliver a push in the background |
 * | badge | the number to be displayed on the icon |
 *
 * @param aliases The aliases to notify.
 * @param userInfo Other data to be sent in the notification.
 * @param completionHandler Completion block.  If an error occurs an NSError will be passed to the block.
 */
- (void)sendNotificationToAliases:(NSArray *)aliases userInfo:(NSDictionary *)userInfo completionHandler:(void (^)(NSError *error))completionHandler;


/**
 * Send Push Notification to tags.
 *
 *
 * The userInfo dictionary can contain custom data and standard apple push notification properties.
 * This implementation will pull out the apns keys and pass all other items as custom data.
 *
 * | key | value|
 * | --- | --- |
 * | alert | the message you want sent |
 * | sound | sound you want played |
 * | content-available | pass in a 1 if you want to deliver a push in the background |
 * | badge | the number to be displayed on the icon |
 *
 * @param tags The tags to notify.
 * @param userInfo Other data to be sent in the notification.
 * @param completionHandler Completion block.  If an error occurs an NSError will be passed to the block.
 */
- (void)sendNotificationToTags:(NSArray *)tags userInfo:(NSDictionary *)userInfo completionHandler:(void (^)(NSError *error))completionHandler;


/**
 When contextual elements are changed, ContextHub will send background push notifications to the application letting you know that new content is available.
 This will allow the context events to update and stay in sync with the server.
 @param application The UIApplication that received the remote notification.
 @param userInfo The NSDictionary that was delivered with the remote notification.
 @param completionHandler A completion block that is executed when the context sync is completed.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)(enum UIBackgroundFetchResult result))completionHandler;


@end