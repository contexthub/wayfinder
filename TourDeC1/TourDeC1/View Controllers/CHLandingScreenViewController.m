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
  NSDictionary *event = notification.userInfo;
  NSString *eventName = [event valueForKeyPath:@"name"];
  NSDictionary *beacon = [event valueForKeyPath:@"beacon"];
  NSString *beaconName = [beacon valueForKeyPath:@"name"];
  NSString *udid = [beacon valueForKeyPath:@"udid"];
  NSString *state = [beacon valueForKeyPath:@"state"];
  
  if([eventName isEqualToString:CHBeaconInEventName]
      && [udid isEqualToString:BeaconUdid]
      && [beaconName isEqualToString:BeaconB1]
      && [state isEqualToString:@"near_state"]){
    [self performSegueWithIdentifier:@"welcomeStartTour" sender:nil];
  }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
