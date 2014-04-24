//
//  CHLandingScreenViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHLandingScreenViewController.h"
#import "CHBeaconMetadataViewController.h"
#import "CHBeaconStore.h"

@interface CHLandingScreenViewController ()

@end

@implementation CHLandingScreenViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(handleEvent:)
                                              name:CCHContextEventManagerDidPostEvent
                                            object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)handleEvent:(NSNotification *)notification {
  if (self.navigationController.topViewController == self) {
    NSDictionary *event = notification.object;
    NSString *eventName = [event valueForKeyPath:@"event.name"];
    NSString *state = [event valueForKeyPath:@"event.data.state"];
    NSDictionary *beacon = [event valueForKeyPath:@"event.data.beacon"];
    NSString *uuid = [beacon valueForKey:@"uuid"];
    
    if([uuid isEqualToString:BeaconUdid] && [self isBeaconIn:eventName]) {
      [[NSNotificationCenter defaultCenter]removeObserver:self];
      [self performSegueWithIdentifier:@"showWelcomeScreen" sender:nil];
    }
    else if([uuid isEqualToString:BeaconUdid] && [self isNearOrImmediateBeacon:eventName state:state]){
      [[NSNotificationCenter defaultCenter]removeObserver:self];
      [self performSegueWithIdentifier:@"atTheLobby" sender:nil];
    }
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"atTheLobby"]){
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    CHBeaconMetadataViewController *beaconMetadataVC = segue.destinationViewController;
    beaconMetadataVC.currentBeaconMetadata = [[CHBeaconStore sharedStore]metadataForBeaconWithName:BeaconB1];
  }
}

@end
