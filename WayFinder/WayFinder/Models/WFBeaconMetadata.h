//
//  WFBeaconMetadata.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFBeaconMetadata : NSObject
//   Different from UUID, this is just an integer to keep track of the number of beacons when created by CHBeaconStore
@property (nonatomic, readwrite) NSInteger beaconID;

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *locationDescription;
@property (nonatomic, strong) NSString *locationInformation;

@property (nonatomic, strong) NSString *nextBeaconName;
@property (nonatomic, strong) NSString *nextBeaconDirection;
@property (nonatomic, strong) NSArray *nextBeaconDirectionBoldWords;
@property (nonatomic, strong) NSString *nextBeaconDirectionImageName;
@property (nonatomic, strong) NSString *nextBeaconMapImageName;


/**
 Designated initializer
 Create a CLBeaconMetadata object from NSDictionary object
 @param data information to be used to create a CLBeaconMetadata object
 */
- (instancetype)initWithData:(NSDictionary *)data;
/**
 Create a CLBeaconMetadata object from a NSNotification object made when ContextHub detects a new beacon
 @param notification notification object containing information about the beacon which triggered an event
 */
+ (instancetype)beaconFromNotification:(NSNotification *)notification;

/**
 Determines whether this beacon and another beacon are the same based on UUID, major and minor values
 @param otherBeacon beacon to be compared against
 */
- (BOOL)isSameBeacon:(WFBeaconMetadata *)otherBeacon;

/**
 Determines whether a beacon is in the proximity (immediate, near, far) of a user's device based on the notification trigged by a beacon
 @param notification notification object containing information about the beacon which triggered an event
 @param beaconProximity proximity which the beacon is in
 */
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification inProximity:(NSString *)beaconProximity;


@end
