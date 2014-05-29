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
    self = [super initWithData:data];
    if(self) {
        self.beaconID = 0;
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

@end
