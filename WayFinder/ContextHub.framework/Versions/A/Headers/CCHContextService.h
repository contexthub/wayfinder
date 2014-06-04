//
//  CCHContextService.h
//  ContextHub
//
//  Created by Kevin Lee on 6/3/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CCHContextEventDelegate.h"
#import "CCHContextEventDataSource.h"
#import "CCHContextEventNotifications.h"

/** 
The CCHContextService
 
 ## Notifications
 
 The following life-cycle notifications are posted.  The notifications are called before the associated delegate methods are called.
 
 ### CCHContextEventManagerWillPostEvent
 the object is the assembled context event and the userInfo object is not set.
 
 ### CCHContextEventManagerDidPostEvent
 the object is the assembled context event and the userInfo object is not set.
 
 ### CCHContextEventManagerDidCancelEvent
 the object is the assembled context event and the userInfo object is not set.
 
 ### CCHContextEventManagerDidDetectEvent
 the object is the triggered event and the userInfo object is not set.
 @warning the notification object is not the fully assembled event.
 
 */
@interface CCHContextService : NSObject <CLLocationManagerDelegate>

/**
 @return The singleton instance of the CCHContextService.
 */
+ (instancetype)sharedService;

/**
 Returns the location from the ContextHub location manager.
 */
- (CLLocation *)currentLocation;

/**
 Synchronizes the context rules and context elements with the local event manager.
 The method gives you a way to load new context information if you are not using background push notifictions.
 @param completion can be nil, is called when synchronization has completed.
 */
- (void)synchronize:(void(^)(BOOL success))completion;

/**
 The ContextService use a CLLocationManager.  If you would like to get CLLocationManagerDelegate delegate calls you cann add your delegate class here.
 */
@property (nonatomic, strong) id <CLLocationManagerDelegate> locationMangagerDelegate;

/**
 The CCHContextEventManagerDelegate
 */
@property (nonatomic, strong) id <CCHContextEventManagerDelegate> delegate;

/**
 The CCHContextEventManagerDataSource
 */
@property (nonatomic, strong) id <CCHContextEventManagerDataSource> dataSource;

@end
