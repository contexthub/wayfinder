//
//  CHBeaconStore.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHBeaconMetadata.h"

@interface CHBeaconStore : NSObject
+ (instancetype)sharedStore;
- (NSArray *)beaconsMetadata;
- (CHBeaconMetadata *)metadataForBeaconWithName:(NSString *)beaconName;
@end
