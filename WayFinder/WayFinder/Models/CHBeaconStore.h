//
//  CHBeaconStore.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHBeaconMetadata.h"

@interface CHBeaconStore : NSObject

@property (nonatomic, strong) NSMutableArray *beacons;

+ (instancetype)sharedStore;
- (CHBeaconMetadata *)metadataForBeaconWithName:(NSString *)beaconName;
- (CHBeaconMetadata *)firstBeacon;
- (CHBeaconMetadata *)lastBeacon;
- (NSUInteger)numBeacons;

@end
