//
//  CHBeaconStore.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHBeaconStore.h"

@interface CHBeaconStore()

@property (nonatomic, strong) NSArray *beaconsDict;

-(void)parseBeacons;

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
        
        NSString *beaconsPath = [[NSBundle mainBundle] pathForResource: @"wayFinderDemo" ofType: @"json"];
        NSData *data = [NSData dataWithContentsOfFile:beaconsPath];
        NSError *error = nil;
        self.beaconsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        [self parseBeacons];
	}
    
	return self;
}

- (void)parseBeacons {
    self.beacons = [NSMutableArray new];
    
    [self.beaconsDict enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CHBeaconMetadata *beacon = [[CHBeaconMetadata alloc]initWithData:(NSDictionary *)obj];
        beacon.beaconID = idx;
        [self.beacons addObject:beacon];
    }];
}

- (CHBeaconMetadata *)metadataForBeaconWithName:(NSString *)beaconName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name LIKE %@",beaconName];
    NSArray *filteredBeacons = [self.beacons filteredArrayUsingPredicate:predicate];
    if([filteredBeacons count] > 0){
        return filteredBeacons[0];
    }
    
    return nil;
}

- (CHBeaconMetadata *)firstBeacon {
    return [self.beacons firstObject];
}

- (CHBeaconMetadata *)lastBeacon {
    return [self.beacons lastObject];
}

- (NSUInteger)numBeacons {
    return [self.beacons count];
}
@end
