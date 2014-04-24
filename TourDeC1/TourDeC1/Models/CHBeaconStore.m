//
//  CHBeaconStore.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHBeaconStore.h"

@interface CHBeaconStore()
@property (nonatomic, strong) NSArray *beacons;
@end

@implementation CHBeaconStore
static CHBeaconStore *__instance = nil;
+ (instancetype)sharedStore {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __instance = [[CHBeaconStore alloc]init];
  });
  return __instance;
}

- (id)init  {
	if ((self = [super init])) {
    NSString *beaconsPath = [[NSBundle mainBundle] pathForResource: @"BeaconMetadata" ofType: @"plist"];
    NSDictionary *beaconsInfo = [NSDictionary dictionaryWithContentsOfFile:beaconsPath];
    self.beacons = beaconsInfo[@"Beacons"];
	}
	return self;
}

- (NSArray *)beaconsMetadata {
  NSMutableArray *parsedBeacons = [NSMutableArray array];
  for(NSDictionary *beaconData in self.beacons){
    CHBeaconMetadata *beacon = [[CHBeaconMetadata alloc]initWithData:beaconData];
    [parsedBeacons addObject:beacon];
  }
  return parsedBeacons;
}

- (CHBeaconMetadata *)metadataForBeaconWithName:(NSString *)beaconName {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name LIKE %@",beaconName];
  NSArray *filteredBeacons = [self.beacons filteredArrayUsingPredicate:predicate];
  if([filteredBeacons count] > 0){
    CHBeaconMetadata *beaconMetadata = [[CHBeaconMetadata alloc]initWithData:filteredBeacons[0]];
    return beaconMetadata;
  }
  return nil;
}

@end
