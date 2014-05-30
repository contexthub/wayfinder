//
//  WFBeaconStore.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WFBeaconMetadata.h"

@interface WFBeaconStore : NSObject

@property (nonatomic, strong) NSMutableArray *beacons;

+ (instancetype)sharedStore;
- (WFBeaconMetadata *)metadataForBeaconWithName:(NSString *)beaconName;
- (WFBeaconMetadata *)firstBeacon;
- (WFBeaconMetadata *)lastBeacon;
- (NSUInteger)numBeacons;

@end
