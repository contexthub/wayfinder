//
//  WFBeaconMetadata.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFBeaconMetadata.h"

@implementation WFBeaconMetadata
- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if(self) {
        self.beaconID = 0;
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

// Creates a beacon from a notification object's data
+ (instancetype)beaconFromNotification:(NSNotification *)notification {
    NSDictionary *event = notification.object;
    NSString *uuid = [event valueForKeyPath:@"event.data.beacon.uuid"];
    NSString *major = [event valueForKeyPath:@"event.data.beacon.major"];
    NSString *minor = [event valueForKeyPath:@"event.data.beacon.minor"];
    
    NSDictionary *data = @{@"uuid":uuid, @"major": major, @"minor": minor, @"name": @"", @"nextBeaconName": @"", @"nextBeaconDirectionName": @"", @"nextBeaconDirectionImageName": @"", @"nextBeaconMapImageName": @""};
    WFBeaconMetadata *beacon = [[WFBeaconMetadata alloc] initWithData:data];
    
    return beacon;
}

// Tests to see if two beacons are the same based on their UUID, major, and minor identifiers
- (BOOL)isSameBeacon:(WFBeaconMetadata *)otherBeacon {
    if ([self.uuid isEqualToString:otherBeacon.uuid] && [self.major isEqualToString:otherBeacon.major] && [self.minor isEqualToString:otherBeacon.minor]) {
        return true;
    }
    
    return false;
}

// Determines if a beacon is in a particular proximity or not based on the notification the beacon triggered
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification inProximity:(NSString *)beaconProximity {
    NSDictionary *event = notification.object;
    NSString *eventName = [event valueForKeyPath:@"event.name"];
    NSString *state = [event valueForKeyPath:@"event.data.state"];
    
    WFBeaconMetadata *notificationBeacon = [WFBeaconMetadata beaconFromNotification:notification];
    
    if (![self isSameBeacon:notificationBeacon]) {
        return false;
    }
    
    if ([beaconProximity isEqualToString:kBeaconProximityImmediate]) {
        if (![self isImmediateToBeacon:eventName state:state]) {
            return false;
        }
    } else if ([beaconProximity isEqualToString:kBeaconProximityNear]) {
        if (![self isNearBeacon:eventName state:state]) {
            return false;
        }
    } else {
        if (![self isFarFromBeacon:eventName state:state]) {
            return false;
        }
    }
    
    return true;
}

- (BOOL)isNearBeacon:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:WFBeaconChangedEventName] && [state isEqualToString:@"near_state"]);
}

- (BOOL)isImmediateToBeacon:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:WFBeaconChangedEventName] && [state isEqualToString:@"immediate_state"]);
}

- (BOOL)isFarFromBeacon:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:WFBeaconChangedEventName] && [state isEqualToString:@"far_state"]);
}

@end
