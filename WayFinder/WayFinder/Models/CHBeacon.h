//
//  CHBeacon.h
//  WayFinder
//
//  Created by Joefrey Kibuule on 5/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The CHBeacon is an object that should be used to get beacon information from a notification sent from the CCHContextEventManager
 */
@interface CHBeacon : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *name;


/**
 Designated initializer
 Create a CHBeacon object from NSDictionary object that contains uuid, major, minor, and name keys
 * | key | value|
 * | --- | --- |
 * | uuid | UUID of the beacon |
 * | major | major value of the beacon |
 * | minor | minor value of the beacon |
 * | name | name of the beacon |
 @param data information to be used to create a CHBeacon object
 */
- (instancetype)initWithData:(NSDictionary *)data;

/**
 Create a CHBeacon object from a NSNotification object made when ContextHub detects a new beacon
 @param notification notification object containing information about the beacon which triggered an event
 */
+ (instancetype)beaconFromNotification:(NSNotification *)notification;

/**
 Determines whether this CHBeacon and another CHBeacon are the same based on UUID, major and minor values
 @param otherBeacon beacon to be compared against
 */
- (BOOL)isSameBeacon:(CHBeacon *)otherBeacon;

/**
 Determines whether a beacon is in the proximity (immediate, near, far) of a user's device based on the notification trigged by a beacon
 @param notification notification object containing information about the beacon which triggered an event
 @param beaconProximity proximity which the beacon is in
 */
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification inProximity:(NSString *)beaconProximity;


@end
