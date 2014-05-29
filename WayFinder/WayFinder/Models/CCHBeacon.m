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
        self.uuid = dictionary[@"uuid"];
        self.major = dictionary[@"major"];
        self.minor = dictionary[@"minor"];
        self.name = dictionary[@"name"];
    }
    
    return self;
}

// Creates a beacon from a notification object's data
+ (instancetype)beaconFromNotification:(NSNotification *)notification {
    NSDictionary *event = notification.object;
    NSString *uuid = [event valueForKeyPath:@"event.data.beacon.uuid"];
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
    } else {
        if (![self isFarFromBeaconWithEvent:eventName state:state]) {
            return false;
        }
    }
    
    return true;
}

- (BOOL)isImmediateToBeaconWithEvent:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:kBeaconChangedEvent] && [state isEqualToString:kBeaconProximityImmediate]);
}

- (BOOL)isNearBeaconWithEvent:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:kBeaconChangedEvent] && [state isEqualToString:kBeaconProximityNear]);
}

- (BOOL)isFarFromBeaconWithEvent:(NSString *)eventName state:(NSString *)state {
    return ([eventName isEqualToString:kBeaconChangedEvent] && [state isEqualToString:kBeaconProximityFar]);
}


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.uuid = [aDecoder decodeObjectForKey:@"uuid"];
    self.major = [aDecoder decodeObjectForKey:@"major"];
    self.minor = [aDecoder decodeObjectForKey:@"minor"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.major forKey:@"major"];
    [aCoder encodeObject:self.minor forKey:@"minor"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end