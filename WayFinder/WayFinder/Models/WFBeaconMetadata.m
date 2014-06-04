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
    self = [super initWithDictionary:data];
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
