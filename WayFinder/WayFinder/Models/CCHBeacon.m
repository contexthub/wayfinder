//
//  CCHBeacon.m
//  WayFinder
//
//  Created by Joefrey Kibuule on 5/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CCHBeacon.h"
#import <ContextHub/ContextHub.h>

@implementation CCHBeacon
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        _uuid = dictionary[@"uuid"];
        _major = dictionary[@"major"];
        _minor = dictionary[@"minor"];
        _name = dictionary[@"name"];
    }
    
    return self;
}

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
    
    NSDictionary *data = @{@"uuid":uuid, @"major": major, @"minor": minor};
    CCHBeacon *beacon = [[CCHBeacon alloc] initWithDictionary:data];
    
    return beacon;
}

// Tests to see if two beacons are the same based on their UUID, major, and minor identifiers
- (BOOL)isSameBeacon:(CCHBeacon *)otherBeacon {
    if ([self.uuid isEqualToString:otherBeacon.uuid] && [self.major isEqualToString:otherBeacon.major] && [self.minor isEqualToString:otherBeacon.minor]) {
        return true;
    }
    
    return false;
}

// Determines what state a beacon is in (in, out, changed) based on the notification trigged by a beacon
- (BOOL)isSameBeaconFromNotification:(NSNotification *)notification withEvent:(NSString *)beaconEvent {
    CCHBeacon *notificationBeacon = [CCHBeacon beaconFromNotification:notification];
    
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
    CCHBeacon *notificationBeacon = [CCHBeacon beaconFromNotification:notification];
    
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
    return [NSString stringWithFormat:@"Beacon: %@, UUID: %@, Major #: %@, Minor #: %@", self.name, self.uuid, self.major, self.minor];
}


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _uuid = [aDecoder decodeObjectForKey:@"uuid"];
        _major = [aDecoder decodeObjectForKey:@"major"];
        _minor = [aDecoder decodeObjectForKey:@"minor"];
        _name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.major forKey:@"major"];
    [aCoder encodeObject:self.minor forKey:@"minor"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end