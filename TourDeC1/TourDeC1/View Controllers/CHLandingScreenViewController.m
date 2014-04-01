//
//  CHLandingScreenViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHLandingScreenViewController.h"

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
      NSDictionary *beacon = [event valueForKeyPath:@"event.data.beacon"];
      NSString *beaconName = [beacon valueForKey:@"name"];
      NSString *udid = [beacon valueForKey:@"uuid"];
      
      if([eventName isEqualToString:CHBeaconInEventName]
          && [udid isEqualToString:BeaconUdid]
          && [beaconName isEqualToString:BeaconB1]) {
        [self performSegueWithIdentifier:@"welcomeStartTour" sender:nil];
      }
    }
}

@end
