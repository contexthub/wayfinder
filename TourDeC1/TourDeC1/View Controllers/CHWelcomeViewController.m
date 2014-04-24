//
//  CHWelcomeViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHWelcomeViewController.h"
#import "CHBeaconMetadataViewController.h"

@interface CHWelcomeViewController ()

@end

@implementation CHWelcomeViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  [self loadCurrentBeaconMetadata];
    
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(handleEvent:)
                                              name:CCHContextEventManagerDidPostEvent
                                            object:nil];
}

- (void)loadCurrentBeaconMetadata {
  self.currentBeaconMetadata = [[CHBeaconStore sharedStore]metadataForBeaconWithName:@"B1"];
}

- (void)viewDidDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)handleEvent:(NSNotification *)notification {
  NSDictionary *event = notification.object;
  NSString *eventName = [event valueForKeyPath:@"event.name"];
  NSString *state = [event valueForKeyPath:@"event.data.state"];
  NSDictionary *beacon = [event valueForKeyPath:@"event.data.beacon"];
  NSString *uuid = [beacon valueForKeyPath:@"uuid"];
  
  if([uuid isEqualToString:self.currentBeaconMetadata.uuid] &&
      [self isNearOrImmediateBeacon:eventName state:state]) {
       [[NSNotificationCenter defaultCenter]removeObserver:self];
       [self performSegueWithIdentifier:@"showBeacon1" sender:nil];
  }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"showBeacon1"]){
    CHBeaconMetadataViewController *destinationVC = segue.destinationViewController;
    destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
  }
}


@end
