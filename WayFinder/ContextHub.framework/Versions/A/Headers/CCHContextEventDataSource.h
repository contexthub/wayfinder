//
//  CCHContextEventDataSource.h
//  ContextHub
//
//  Created by Kevin Lee on 6/3/14.
//  Copyright (c) 2014 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Implement the data source when you want to add custom data to the context event.
 */
@protocol CCHContextEventManagerDataSource <NSObject>

@optional

/**
 Returns a serializable dictionary that will get added to context event payload property.
 @param event is the event that will be sent to the server.
 */
- (NSDictionary *)payloadForEvent:(NSDictionary *)event;

/**
 Returns a serializable dictionary that will get added to context event payload property.
 @param event is the event that will be sent to the server.
 @param eventManager the CCHContextEventManager that will send the event.
 */
- (NSDictionary *)contextEventManager:(CCHContextEventManager *)eventManager payloadForEvent:(NSDictionary *)event;

@end
