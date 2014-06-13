//
//  CLBeaconRegion+ContextHub.m
//  WayFinder
//
//  Created by Joefrey Kibuule on 5/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CLBeaconRegion+ContextHub.h"
#import <ContextHub/ContextHub.h>

@implementation CLBeaconRegion (ContextHub)

// Creates a beacon from a notification object's data
+ (instancetype)beaconFromNotification:(NSNotification *)notification {
    NSDictionary *event = notification.object;
    NSString *uuid = [event valueForKeyPath:@"event.data.beacon.uuid"];
    
    // Invalid UUID = invalid beacon
    if (!uuid || [uuid isEqualToString:@""]) {
        return nil;
    }
    
    NSString *major = [event valueForKeyPath:@"event.data.beacon.major"];
    NSString *minor = [event valueForKeyPath:@"event.data.beacon.minor"];
    
    CLBeaconRegion *beaconRegion =  [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] major:[major integerValue]  minor:[minor integerValue] identifier:@""];
    
    return beaconRegion;
}

// Tests to see if two beacons are the same based on their UUID, major, and minor identifiers
- (BOOL)isSameBeacon:(CLBeaconRegion *)otherBeacon {
    if ([self.proximityUUID isEqual:otherBeacon.proximityUUID] && [self.major isEqual:otherBeacon.major] && [self.minor isEqual:otherBeacon.minor]) {
        return true;
    }
    
    return false;
}

// Determines what state a beacon is in (in, out, changed) based on the notification trigged by a beacon
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification withEvent:(NSString *)beaconEvent {
    CLBeaconRegion *notificationBeacon = [CLBeaconRegion beaconFromNotification:notification];
    
    if (![self isSameBeacon:notificationBeacon]) {
        return false;
    }
    
    NSDictionary *event = notification.object;
    NSString *eventName = [event valueForKeyPath:@"event.name"];
    
    if ([beaconEvent isEqualToString:kBeaconInEvent]) {
        if (![eventName isEqualToString:kBeaconInEvent]) {
            return false;
        }
    } else if ([beaconEvent isEqualToString:kBeaconOutEvent]) {
        if (![eventName isEqualToString:kBeaconOutEvent]) {
            return false;
        }
    } else if ([beaconEvent isEqualToString:kBeaconChangedEvent]){
        if (![eventName isEqualToString:kBeaconChangedEvent]) {
            return false;
        }
    }
    
    return true;
}

// Determines if a beacon is in a particular proximity or not based on the notification the beacon triggered
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification inProximity:(NSString *)beaconProximity {
    CLBeaconRegion *notificationBeacon = [CLBeaconRegion beaconFromNotification:notification];
    
    if (![self isSameBeacon:notificationBeacon]) {
        return false;
    }
    
    NSDictionary *event = notification.object;
    NSString *eventName = [event valueForKeyPath:@"event.name"];
    NSString *state = [event valueForKeyPath:@"event.data.state"];
    
    if ([beaconProximity isEqualToString:kBeaconProximityImmediate]) {
        if (![self isImmediateToBeaconWithEvent:eventName state:state]) {
            return false;
        }
    } else if ([beaconProximity isEqualToString:kBeaconProximityNear]) {
        if (![self isNearBeaconWithEvent:eventName state:state]) {
            return false;
        }
    } else if ([beaconProximity isEqualToString:kBeaconProximityFar]){
        if (![self isFarFromBeaconWithEvent:eventName state:state]) {
            return false;
        }
    }
    
    return true;
}

#pragma mark - Helper methods

- (BOOL)isImmediateToBeaconWithEvent:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:kBeaconChangedEvent] && [state isEqualToString:kBeaconProximityImmediate]);
}

- (BOOL)isNearBeaconWithEvent:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:kBeaconChangedEvent] && [state isEqualToString:kBeaconProximityNear]);
}

- (BOOL)isFarFromBeaconWithEvent:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:kBeaconChangedEvent] && [state isEqualToString:kBeaconProximityFar]);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Beacon: %@, UUID: %@, Major #: %@, Minor #: %@", self.identifier, self.proximityUUID, self.major, self.minor];
}

@end