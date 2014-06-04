//
//  CCHContextEventNotifications.h
//  ContextHub
//
//  Created by Kevin Lee on 6/4/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>

///--------------------
/// @name Notifications
///--------------------

/*
 Posted before an event is posted to ContextHub
 */
extern NSString * const CCHContextEventManagerWillPostEvent;

/*
 Posted after an event has been posted to ContextHub
 */
extern NSString * const CCHContextEventManagerDidPostEvent;

/*
 Posted when the event was cancelled.
 */
extern NSString * const CCHContextEventManagerDidCancelEvent;

/*
 Posted when an event is detected.
 */
extern NSString * const CCHContextEventManagerDidDetectEvent;


