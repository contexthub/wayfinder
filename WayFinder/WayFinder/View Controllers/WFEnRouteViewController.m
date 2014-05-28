//
//  WFEnRouteViewController.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFEnRouteViewController.h"
#import "WFAppDelegate.h"

@interface WFEnRouteViewController ()

@end

@implementation WFEnRouteViewController

- (void)viewDidLoad {
  [super viewDidLoad];

    [self layoutMetadata];
    [self loadNextBeaconMetadata];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleEvent:)
                                                name:CCHContextEventManagerDidPostEvent
                                              object:nil];
}

- (void)layoutMetadata {
    NSMutableAttributedString *directionsText;
    self.mapView.image = [UIImage imageNamed:self.currentBeaconMetadata.nextBeaconMapImageName];
    self.navigationDirectionsImageView.image = [UIImage imageNamed:self.currentBeaconMetadata.nextBeaconDirectionImageName];
    
    // Setup such that specific words are in bold
    directionsText = [[NSMutableAttributedString alloc] initWithString:self.currentBeaconMetadata.nextBeaconDirection];
    
    for (NSString *boldWord in self.currentBeaconMetadata.nextBeaconDirectionBoldWords) {
        [directionsText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AvenirNext-Bold" size:20.0] range:NSRangeFromString(boldWord)];
    }
    [self.directionsLabel setAttributedText:directionsText];
}

- (void)loadNextBeaconMetadata {
    self.destinationBeaconMetadata = [[WFBeaconStore sharedStore]metadataForBeaconWithName:self.currentBeaconMetadata.nextBeaconName];
}

- (void)handleEvent:(NSNotification *)notification {
    // Grab the next beacon
    WFBeaconMetadata *nextBeacon = [[WFBeaconStore sharedStore] metadataForBeaconWithName:self.destinationBeaconMetadata.name];
    
    // Detect if the next beacon is nearby
    if ([nextBeacon isSameBeaconFromNotification:notification inProximity:kBeaconProximityImmediate] || [nextBeacon isSameBeaconFromNotification:notification inProximity:kBeaconProximityNear]) {
        // Stop notifications
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        
        [self performSegueWithIdentifier:@"showBeacon" sender:nil];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WFViewController *wfViewController = segue.destinationViewController;
    wfViewController.currentBeaconMetadata = self.destinationBeaconMetadata;
}

@end