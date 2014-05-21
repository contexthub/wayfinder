//
//  CHBeaconMetadata.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHBeaconMetadata : NSObject
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *locationDescription;
@property (nonatomic, strong) NSString *locationInformation;
@property (nonatomic, strong) NSString *nextBeaconName;
@property (nonatomic, strong) NSString *nextBeaconDirection;
@property (nonatomic, strong) NSString *nextBeaconDirectionImageName;
@property (nonatomic, strong) NSString *nextBeaconMapImageName;

// Designated initializer
- (instancetype)initWithData:(NSDictionary *)data;
+ (instancetype)beaconFromNotification:(NSNotification *)notification;

- (BOOL)isNearOrImmediateBeaconWithNotification:(NSNotification *)notification;
- (BOOL)isSameBeacon:(CHBeaconMetadata *)otherBeacon;

@end
