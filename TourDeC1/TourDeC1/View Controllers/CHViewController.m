//
//  CHViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 4/7/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHViewController.h"

@interface CHViewController ()

@end

@implementation CHViewController

- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
  return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)isBeaconIn:(NSString *)eventName {
  return ([eventName isEqualToString:CHBeaconInEventName]);
}

- (BOOL)isNearOrImmediateBeacon:(NSString *)eventName state:(NSString *)state {
  return ([eventName isEqualToString:CHBeaconChangedEventName] &&
          ([state isEqualToString:@"near_state"] || [state isEqualToString:@"immediate_state"] ));
}


@end
