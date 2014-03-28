//
//  CHWelcomeViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHWelcomeViewController.h"
#import "CHEnRouteViewController.h"

@interface CHWelcomeViewController ()

@end

@implementation CHWelcomeViewController


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
  NSDictionary *event = notification.userInfo;
  NSString *eventName = [event valueForKeyPath:@"name"];
  NSDictionary *beacon = [event valueForKeyPath:@"beacon"];
  NSString *beaconName = [beacon valueForKeyPath:@"name"];
  NSString *udid = [beacon valueForKeyPath:@"udid"];
  NSString *state = [beacon valueForKeyPath:@"state"];
  
  if([eventName isEqualToString:CHBeaconInEventName]
     && [beaconName isEqualToString:BeaconB1]
     && [udid isEqualToString:BeaconUdid]
     && [state isEqualToString:@"immediate_state"]){
    [self performSegueWithIdentifier:@"startedTour" sender:nil];
  }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"startedTour"]){
    CHEnRouteViewController *destinationVC = segue.destinationViewController;
    [destinationVC setUserAtBeaconName:BeaconB1];
  }
}


@end
