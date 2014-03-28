//
//  CHEnRouteViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHEnRouteViewController.h"
#import "CHAppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "CHBeaconMetadataViewController.h"


@interface CHEnRouteViewController ()

@end

@implementation CHEnRouteViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(handleEvent:)
                                              name:CCHContextEventManagerDidPostEvent object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutMetadata];
    [self loadNextBeaconMetadata];
}

- (void)layoutMetadata {
    self.userAtBeaconName = self.currentBeaconMetadata.name;
    [self.mapView setImageWithURL:[NSURL URLWithString:self.currentBeaconMetadata.nextSegment]];
}

- (void)loadNextBeaconMetadata {
    
   NSArray *beaconsMetadata = [[CHAppDelegate sharedAppDelegate]beaconsMetadata];
    NSString *nextBeaconName =@"";
    
    if ([self.userAtBeaconName isEqual:@"B1"]) {
        nextBeaconName = @"B2";
    } else {
        nextBeaconName = @"B3";
    }
    
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name like %@", nextBeaconName];
   NSArray *filteredData = [beaconsMetadata filteredArrayUsingPredicate:predicate];
   self.destinationBeaconMetadata = filteredData[0];
}

- (void)handleEvent:(NSNotification *)notification {
    NSDictionary *event = notification.object;
    NSString *eventName = [event valueForKeyPath:@"event.name"];
    NSDictionary *beacon = [event valueForKeyPath:@"event.data.beacon"];
    NSString *udid = [beacon valueForKeyPath:@"uuid"];
    NSString *state = [beacon valueForKeyPath:@"proximity"];

  
    if([eventName isEqualToString:CHBeaconInEventName]) {
        if ([udid isEqualToString:self.destinationBeaconMetadata.udid]
            && [state isEqualToString:@"near_state"]) {
            [self performSegueWithIdentifier:@"showMetadata" sender:nil];
        }
    }
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"showMetadata"]){
    CHBeaconMetadataViewController *metadataViewController = segue.destinationViewController;
    metadataViewController.currentBeaconMetadata = self.destinationBeaconMetadata;
  }
}


@end
