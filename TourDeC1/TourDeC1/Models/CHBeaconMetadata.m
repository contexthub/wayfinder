//
//  CHBeaconMetadata.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHBeaconMetadata.h"

@implementation CHBeaconMetadata
- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if(self) {
      self.uuid = data[@"uuid"];
        self.major = data[@"major"];
        self.minor = data[@"minor"];
        self.name = data[@"name"];
        self.locationDescription = data[@"locationDescription"];
        self.locationInformation = data[@"locationInformation"];
        self.nextBeaconName = data[@"nextBeaconName"];
        self.nextBeaconDirection = data[@"nextBeaconDirection"];
        self.nextBeaconDirectionBoldWords = data[@"nextBeaconDirectionBoldWords"];
        self.nextBeaconDirectionImageName = data[@"nextBeaconDirectionImageName"];
        self.nextBeaconMapImageName = data[@"nextBeaconMapImageName"];
    }
    
    return self;
}

+ (instancetype)beaconFromNotification:(NSNotification *)notification {
    // Grab data from the notification
    NSDictionary *event = notification.object;
    NSString *uuid = [event valueForKeyPath:@"event.data.beacon.uuid"];
    NSString *major = [event valueForKeyPath:@"event.data.beacon.major"];
    NSString *minor = [event valueForKeyPath:@"event.data.beacon.minor"];
    
    // Create a CHBeaconMedata object from the data in the notification
    NSDictionary *data = @{@"uuid":uuid, @"major": major, @"minor": minor, @"name": @"", @"nextBeaconName": @"", @"nextBeaconDirectionName": @"", @"nextBeaconDirectionImageName": @"", @"nextBeaconMapImageName": @""};
    CHBeaconMetadata *beacon = [[CHBeaconMetadata alloc] initWithData:data];
    
    return beacon;
}

// Determines whether a notification that comes in is the beacon we are interested in and whether we are near it
- (BOOL)isNearOrImmediateBeaconWithNotification:(NSNotification *)notification {
    // Grab data from the notification
    NSDictionary *event = notification.object;
    NSString *eventName = [event valueForKeyPath:@"event.name"];
    NSString *state = [event valueForKeyPath:@"event.data.state"];
    
    CHBeaconMetadata *notificationBeacon = [CHBeaconMetadata beaconFromNotification:notification];
    
    // Is this the beacon we are interested in?
    if (![self isSameBeacon:notificationBeacon]) {
        return false;
    }
    
    // Are we near this beacon?
    if (![self isNearOrImmediateBeacon:eventName state:state]) {
        return false;
    }
    
    return true;
}

// Tests to see if two beacons are the same based on their UUID, major, and minor identifiers
- (BOOL)isSameBeacon:(CHBeaconMetadata *)otherBeacon {
    if ([self.uuid isEqualToString:otherBeacon.uuid] && [self.major isEqualToString:otherBeacon.major] && [self.minor isEqualToString:otherBeacon.minor]) {
        return true;
    }
    
    return false;
}

- (BOOL)isNearOrImmediateBeacon:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:CHBeaconChangedEventName] &&
            ([state isEqualToString:@"near_state"] || [state isEqualToString:@"immediate_state"] ));
}
@end
