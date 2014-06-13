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

// Grabs beacon data from the server
- (void)getBeaconsFromServer {
    [[CCHBeaconService sharedInstance] getBeaconsWithTags:@[@"wayfinder"] completionHandler:^(NSArray *beacons, NSError *error) {
        if (!error)
        {
            if (beacons.count > 0) {
                self.beacons = [NSMutableArray new];
                
                [beacons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    CLBeaconRegion *beaconRegion = [CCHBeaconService regionForBeacon:obj];
                    NSDictionary *beaconDict = @{@"name":obj[@"name"], @"uuid":[beaconRegion.proximityUUID UUIDString], @"major":[beaconRegion.major stringValue], @"minor":[beaconRegion.minor stringValue]};
                    WFBeaconMetadata *beacon = [[WFBeaconMetadata alloc] initWithDictionary:beaconDict];
                    beacon.beaconID = idx;
                    [self.beacons addObject:beacon];
                }];
                
                [self updateBeaconDataFromServer];
            } else {
                // No beacons in server
                NSLog(@"No beacons on server");
                
                // Send a notifications that there are no beacons on the server
                [[NSNotificationCenter defaultCenter] postNotificationName:WFNoBeaconsOnServerNotification object:nil];
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
}

// Grabs vault data from the server
- (void)updateBeaconDataFromServer {
    [[CCHVault sharedInstance] getItemsInContainer:@"wayfinderdemo" completionHandler:^(NSArray *responses, NSError *error) {
        if (!error) {
            if (responses.count > 0) {
                [responses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSString *beaconName = obj[@"name"];
                    WFBeaconMetadata *beacon = [self metadataForBeaconWithName:beaconName];
                    
                    if (beacon) {
                        beacon.locationDescription = obj[@"locationDescription"];
                        beacon.locationInformation = obj[@"locationInformation"];
                        beacon.nextBeaconName = obj[@"nextBeaconName"];
                        beacon.nextBeaconDirection = obj[@"nextBeaconDirection"];
                        beacon.nextBeaconDirectionImageName = obj[@"nextBeaconDirectionImageName"];
                        beacon.nextBeaconMapImageName = obj[@"nextBeaconMapImageName"];
                        
                        // Strip extraneous text to make for a properly formatted array of BOLD words
                        NSString *boldWords = obj[@"nextBeaconDirectionBoldWords"];
                        boldWords = [boldWords stringByReplacingOccurrencesOfString:@"[" withString:@""];
                        boldWords = [boldWords stringByReplacingOccurrencesOfString:@"]" withString:@""];
                        boldWords = [boldWords stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                        boldWords = [boldWords stringByReplacingOccurrencesOfString:@" " withString:@""];
                        beacon.nextBeaconDirectionBoldWords = [boldWords componentsSeparatedByString:@","];
                    }
                }];
                
                [self sortBeacons];
            } else {
                NSLog(@"No vault items in container");
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
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