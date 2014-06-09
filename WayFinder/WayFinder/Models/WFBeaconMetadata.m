//
//  WFBeaconMetadata.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFBeaconMetadata.h"

@implementation WFBeaconMetadata
- (instancetype)initWithDictionary:(NSDictionary *)data {
    // Pull the data out of the dictionary to create a CLBeaconRegion
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:data[@"uuid"]];
    NSString *major = data[@"major"];
    NSString *minor = data[@"minor"];
    NSString *identifier = data[@"name"];
    self = [super initWithProximityUUID:uuid major:[major integerValue] minor:[minor integerValue] identifier:identifier];
    
    // Setup other data
    if(self) {
        _beaconID = 0;
        _locationDescription = data[@"locationDescription"];
        _locationInformation = data[@"locationInformation"];
        _nextBeaconName = data[@"nextBeaconName"];
        _nextBeaconDirection = data[@"nextBeaconDirection"];
        _nextBeaconDirectionBoldWords = data[@"nextBeaconDirectionBoldWords"];
        _nextBeaconDirectionImageName = data[@"nextBeaconDirectionImageName"];
        _nextBeaconMapImageName = data[@"nextBeaconMapImageName"];
    }
    
    return self;
}

@end
