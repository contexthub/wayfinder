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
#import "CHProductRoomViewController.h"
#import "CHDeliRoomViewController.h"
#import "CHCEORoomViewController.h"
#import "CHExxonRoomViewController.h"


@interface CHEnRouteViewController ()

@end

@implementation CHEnRouteViewController

- (void)viewDidLoad {
  [super viewDidLoad];

    [self layoutMetadata];
    [self loadNextBeaconMetadata];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(handleEvent:)
                                                    name:CCHContextEventManagerDidPostEvent object:nil];
}

- (void)layoutMetadata {
    NSMutableAttributedString *directionsText;
    self.mapView.image = [UIImage imageNamed:self.currentBeaconMetadata.nextBeaconMapImageName];
    self.navigationDirectionsImageView.image = [UIImage imageNamed:self.currentBeaconMetadata.nextBeaconDirectionImageName];
    
    directionsText = [[NSMutableAttributedString alloc] initWithString:self.currentBeaconMetadata.nextBeaconDirection];
    
    for (NSString *boldWord in self.currentBeaconMetadata.nextBeaconDirectionBoldWords) {
        [directionsText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-Bold" size:20.0] range:NSRangeFromString(boldWord)];
    }
    [self.directionsLabel setAttributedText:directionsText];
}

- (void)loadNextBeaconMetadata {
    self.destinationBeaconMetadata = [[CHBeaconStore sharedStore]metadataForBeaconWithName:self.currentBeaconMetadata.nextBeaconName];
}

- (void)handleEvent:(NSNotification *)notification {
    // Grab the next beacon
    CHBeaconMetadata *nextBeacon = [[CHBeaconStore sharedStore] metadataForBeaconWithName:self.destinationBeaconMetadata.name];
    
    // Detect the next beacon for the lobby to show the "Start Tour" button
    if ([nextBeacon isNearOrImmediateBeaconWithNotification:notification]) {
        // Stop notifications
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        
        // Figure out which beacon this is and performSegue accordingly
        if ([nextBeacon.name isEqualToString:BeaconB2]) {
            [self performSegueWithIdentifier:@"showBeacon2" sender:nil];
        } else if ([nextBeacon.name isEqualToString:BeaconB3]) {
            [self performSegueWithIdentifier:@"showBeacon3" sender:nil];
        } else if ([nextBeacon.name isEqualToString:BeaconB4]) {
            [self performSegueWithIdentifier:@"showBeacon4" sender:nil];
        } else if ([nextBeacon.name isEqualToString:BeaconB5]) {
            [self performSegueWithIdentifier:@"showBeacon5" sender:nil];
        }
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CHViewController *chViewController = segue.destinationViewController;
    chViewController.currentBeaconMetadata = self.destinationBeaconMetadata;
}

@end
