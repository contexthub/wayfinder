//
//  CLBeaconRegion+ContextHub.h
//  WayFinder
//
//  Created by Joefrey Kibuule on 5/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#define kBeaconInEvent @"beacon_in"
#define kBeaconOutEvent @"beacon_out"
#define kBeaconChangedEvent @"beacon_changed"
#define kBeaconProximityFar @"far_state"
#define kBeaconProximityNear @"near_state"
#define kBeaconProximityImmediate @"immediate_state"

/**
 The ContextHub category extensions to CLBeaconRegion allow for easy retrieval and comparison of beacons generated from CCHSensorPipeline events
 */
@interface CLBeaconRegion (ContextHub)

/**
 Create a CLBeaconRegion object from a NSNotification object made when ContextHub detects a new beacon
 @param notification notification object containing information about the beacon which triggered an event
 */
+ (instancetype)beaconFromNotification:(NSNotification *)notification;

/**
 Determines whether this CLBeaconRegion and another CLBeaconRegion are the same based on UUID, major and minor values
 @param otherBeacon beacon to be compared against
 */
- (BOOL)isSameBeacon:(CLBeaconRegion *)otherBeacon;

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
