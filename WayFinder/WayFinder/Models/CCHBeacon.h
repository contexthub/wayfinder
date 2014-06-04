//
//  CCHBeacon.h
//  WayFinder
//
//  Created by Joefrey Kibuule on 5/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBeaconInEvent @"beacon_in"
#define kBeaconOutEvent @"beacon_out"
#define kBeaconChangedEvent @"beacon_changed"
#define kBeaconProximityFar @"far_state"
#define kBeaconProximityNear @"near_state"
#define kBeaconProximityImmediate @"immediate_state"

/**
 The CCHBeacon is an object that should be used to get beacon information from a notification sent from the CCHContextEventManager
 */
@interface CCHBeacon : NSObject <NSCoding>

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *name;


/**
 Designated initializer
 Create a CCHBeacon object from NSDictionary object that contains uuid, major, minor, and name keys
 * | key   | value |
 * | ----- | ----- |
 * | uuid  | UUID of the beacon |
 * | major | major value of the beacon |
 * | minor | minor value of the beacon |
 * | name  | name of the beacon |
 @param dictionary information to be used to create a CCHBeacon object
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 Create a CCHBeacon object from a NSNotification object made when ContextHub detects a new beacon
 @param notification notification object containing information about the beacon which triggered an event
 */
+ (instancetype)beaconFromNotification:(NSNotification *)notification;

/**
 Determines whether this CCHBeacon and another CCHBeacon are the same based on UUID, major and minor values
 @param otherBeacon beacon to be compared against
 */
- (BOOL)isSameBeacon:(CCHBeacon *)otherBeacon;

/**
 Determines what state a beacon is in (in, out, changed) based on the notification trigged by a beacon
 @param notification notification object containing information about the beacon which triggered an event
 @param beaconEvent event name for the beacon (kBeaconInEvent, kBeaconOutEvent, kBeaconChangedEvent)
 */
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification withEvent:(NSString *)beaconEvent;

/**
 Determines whether a beacon is in the proximity (immediate, near, far) of a user's device based on the notification trigged by a beacon
 @param notification notification object containing information about the beacon which triggered an event
 @param beaconProximity proximity which the beacon is in (kBeaconProximityImmediate, kBeaconProximityNear, kBeaconProximityFar)
 */
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification inProximity:(NSString *)beaconProximity;


@end
