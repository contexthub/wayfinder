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
    self.major = data[@"major"];
    self.minor = data[@"minor"];
    self.name = data[@"name"];
    self.uuid = data[@"uuid"];
    self.nextBeaconName = data[@"nextBeaconName"];
    self.locationOnMapImageName = data[@"locationOnMapImageName"];
  }
  return self;
}
@end
