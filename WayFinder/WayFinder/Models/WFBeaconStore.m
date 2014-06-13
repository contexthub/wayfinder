//
//  WFBeaconStore.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/1/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFBeaconStore.h"

#import "WFBeaconMetadata.h"

@interface WFBeaconStore()

@property (nonatomic, strong) NSArray *beaconsDict;

-(void)getBeaconsFromFile;

@end


@implementation WFBeaconStore

static WFBeaconStore *__instance = nil;

+ (instancetype)sharedStore {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[WFBeaconStore alloc]init];
    });
    
    return __instance;
}

// Parses JSON into array of WFBeaconMetadata objects
- (void)getBeaconsFromFile {
    NSString *beaconsPath = [[NSBundle mainBundle] pathForResource: @"wayFinderDemo" ofType: @"json"];
    NSData *data = [NSData dataWithContentsOfFile:beaconsPath];
    NSError *error = nil;
    
    self.beacons = [NSMutableArray new];
    self.beaconsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    [self.beaconsDict enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WFBeaconMetadata *beacon = [[WFBeaconMetadata alloc]initWithDictionary:(NSDictionary *)obj];
        beacon.beaconID = idx;
        [self.beacons addObject:beacon];
    }];
}

// Searches the beacon store for a beacon with the same name
- (WFBeaconMetadata *)metadataForBeaconWithName:(NSString *)beaconName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.identifier LIKE %@", beaconName];
    NSArray *filteredBeacons = [self.beacons filteredArrayUsingPredicate:predicate];
    if([filteredBeacons count] > 0){
        return filteredBeacons[0];
    }
    
    return nil;
}

- (WFBeaconMetadata *)firstBeacon {
    return [self.beacons firstObject];
}

- (WFBeaconMetadata *)lastBeacon {
    return [self.beacons lastObject];
}

- (NSUInteger)numBeacons {
    return [self.beacons count];
}

- (void)sortBeacons {
    NSSortDescriptor *sortByMajorValue = [[NSSortDescriptor alloc] initWithKey:@"major" ascending:YES];
    NSSortDescriptor *sortByMinorValue = [[NSSortDescriptor alloc] initWithKey:@"minor" ascending:YES];
    
    [self.beacons sortUsingDescriptors:@[sortByMajorValue, sortByMinorValue]];
    
    // Reassign indicies
    [self.beacons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        WFBeaconMetadata *beacon = obj;
        beacon.beaconID = idx;
    }];
}

@end