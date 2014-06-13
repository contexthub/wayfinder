//
//  WFBeaconMetadata.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CLBeaconRegion+ContextHub.h"

@interface WFBeaconMetadata : CLBeaconRegion

- (instancetype)initWithDictionary:(NSDictionary *)data;

//   Different from UUID, this is just an integer to keep track of the number of beacons when created by WFBeaconStore
@property (nonatomic, readwrite) NSInteger beaconID;

@property (nonatomic, copy) NSString *locationDescription;
@property (nonatomic, copy) NSString *locationInformation;

@property (nonatomic, copy) NSString *nextBeaconName;
@property (nonatomic, copy) NSString *nextBeaconDirection;
@property (nonatomic, strong) NSArray *nextBeaconDirectionBoldWords;
@property (nonatomic, copy) NSString *nextBeaconDirectionImageName;
@property (nonatomic, copy) NSString *nextBeaconMapImageName;

@end