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
      [self loadCurrentBeaconMetadata];
    
  [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(handleEvent:)
                                              name:CCHContextEventManagerDidPostEvent
                                            object:nil];
}

- (void)loadCurrentBeaconMetadata {
    NSArray *beaconsMetadata = [[CHAppDelegate sharedAppDelegate]beaconsMetadata];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name like B1"];
    NSArray *filteredData = [beaconsMetadata filteredArrayUsingPredicate:predicate];
    self.currentBeaconMetadata = filteredData[0];
}

- (void)viewDidDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)handleEvent:(NSNotification *)notification {
  NSDictionary *event = notification.object;
  NSString *eventName = [event valueForKeyPath:@"event.name"];
  NSDictionary *beacon = [event valueForKeyPath:@"event.data.beacon"];
  NSString *udid = [beacon valueForKeyPath:@"uuid"];
  NSString *state = [beacon valueForKeyPath:@"proximity"];
  
    if([eventName isEqualToString:CHBeaconChangedEventName]) {
         if ([udid isEqualToString:self.currentBeaconMetadata.udid]
             && [state isEqualToString:@"immediate_state"]) {
             [self performSegueWithIdentifier:@"startTour" sender:nil];
         }
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if([segue.identifier isEqualToString:@"startedTour"]){
    CHEnRouteViewController *destinationVC = segue.destinationViewController;
      destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
    [destinationVC setUserAtBeaconName:BeaconB1];
  }
}


@end
