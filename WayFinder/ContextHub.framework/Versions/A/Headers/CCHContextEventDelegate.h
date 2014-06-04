//
//  CCHContextEventProtocol.h
//  ContextHub
//
//  Created by Kevin Lee on 6/3/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CCHContextEventManager;
/**
 Implement the delegate if you want to take action before or after an event is sent to ContextHub.  You can also decide keep an event from firing.
 */
@protocol CCHContextEventManagerDelegate <NSObject>

@optional
/**
 Sometimes you may want to keep an event from posting to the ContextHub service.  This method gives you the opportunity to stop the call.
 If you return NO, none of the other delegate methods will git called, and the event will be discarded.
 @note No history of the event will be captured if you return NO here.
 returns boolean indicating if the event should be posted to ContextHUB
 @param eventManager the CCHContextEventManager that handling the context event.
 @param event the context event that triggered the call.
 */
- (BOOL)contextEventManager:(CCHContextEventManager *)eventManager
            shouldPostEvent:(NSDictionary *)event;


/**
 Called before an event was sent to ContextHub.
 @param eventManager the CCHContextEventManager that will the event
 @param event the context event that was sent to ContextHub
 */
- (void)contextEventManager:(CCHContextEventManager *)eventManager
              willPostEvent:(NSDictionary *)event;


/**
 Called after an event was sent to ContextHub.
 @param eventManager the CCHContextEventManager that sent the event
 @param event the context event that was sent to ContextHub
 */
- (void)contextEventManager:(CCHContextEventManager *)eventManager
               didPostEvent:(NSDictionary *)event;


@end




