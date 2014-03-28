//
//  CHEnRouteViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHEnRouteViewController.h"
#import "CHAppDelegate.h"
#import "CHBeaconMetadata.h"
#import "UIImageView+AFNetworking.h"
#import "CHBeaconMetadataViewController.h"


@interface CHEnRouteViewController ()
@property (nonatomic, strong) CHBeaconMetadata *currentBeaconMetadata;
@end

@implementation CHEnRouteViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCurrentBeaconMetadata];
  [self.mapView setImageWithURL:[NSURL URLWithString:self.currentBeaconMetadata.nextSegment]];
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(handleEvent:)
                                              name:CCHContextEventManagerDidPostEvent object:nil];
}

- (void)loadCurrentBeaconMetadata {
   NSArray *beaconsMetadata = [[CHAppDelegate sharedAppDelegate]beaconsMetadata];
   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name like %@", self.userAtBeaconName];
   NSArray *filteredData = [beaconsMetadata filteredArrayUsingPredicate:predicate];
   self.currentBeaconMetadata = filteredData[0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleEvent:(NSNotification *)notification {
  NSDictionary *event = notification.userInfo;
  NSString *eventName = [event valueForKeyPath:@"name"];
  NSDictionary *beacon = [event valueForKeyPath:@"beacon"];
  NSString *beaconName = [beacon valueForKeyPath:@"name"];
  NSString *udid = [beacon valueForKeyPath:@"udid"];
  NSString *state = [beacon valueForKeyPath:@"state"];
  
  if([eventName isEqualToString:CHBeaconInEventName]
     && [beaconName isEqualToString:self.currentBeaconMetadata.nextBeaconName]
     && [udid isEqualToString:BeaconUdid]
     && [state isEqualToString:@"near_state"]){
    [self performSegueWithIdentifier:@"showMetadata" sender:nil];
  }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"showMetadata"]){
    CHBeaconMetadataViewController *metadataViewController = segue.destinationViewController;
    metadataViewController.currentBeaconMetadata = self.currentBeaconMetadata;
  }
}


@end
