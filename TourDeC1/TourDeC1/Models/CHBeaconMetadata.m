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
  NSDictionary *metadata = data[@"metadata"];
  if(self) {
    self.major = metadata[@"major"];
    self.minor = metadata[@"minor"];
    self.name = metadata[@"name"];
    self.udid = metadata[@"udid"];
    self.nextBeaconName = data[@"next_beacon"];
    self.nextSegment = data[@"next_segment"];
    self.nextBeaconUDID = data[@"udid"];
  }
  return self;
}
@end
