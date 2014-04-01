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
  NSMutableAttributedString *directionsText;
  //[self.mapView setImageWithURL:[NSURL URLWithString:self.currentBeaconMetadata.nextSegment]];
    
  if([self.currentBeaconMetadata.name isEqualToString:BeaconB1]){
    [self.navigationDirectionsImageView setImage:[UIImage imageNamed:@"straight-left-arrow"]];
    directionsText = [[NSMutableAttributedString alloc]initWithString:@"Go STRAIGHT and turn LEFT"];
    [directionsText addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"AvenirNext-Bold"
                                                 size:20.0]
                           range:NSRangeFromString(@"STRAIGHT")];
    [directionsText addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"AvenirNext-Bold"
                                                 size:20.0]
                           range:NSRangeFromString(@"LEFT")];
    [self.directionsLabel setAttributedText:directionsText];
  }else if([self.currentBeaconMetadata.name isEqualToString:BeaconB2]){
    [self.navigationDirectionsImageView setImage:[UIImage imageNamed:@"left-arrow.png"]];
    directionsText = [[NSMutableAttributedString alloc]initWithString:@"Turn LEFT"];
    [directionsText addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"AvenirNext-Bold"
                                                 size:20.0]
                           range:NSRangeFromString(@"LEFT")];
    [self.directionsLabel setAttributedText:directionsText];
  }
}

- (void)loadNextBeaconMetadata {
    NSString *nextBeaconName =@"";
    
    if ([self.userAtBeaconName isEqual:BeaconB1]) {
        nextBeaconName = BeaconB2 ;
    } else {
        nextBeaconName = BeaconB3 ;
    }
   self.destinationBeaconMetadata = [[CHBeaconStore sharedStore]metadataForBeaconWithName:nextBeaconName];
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
