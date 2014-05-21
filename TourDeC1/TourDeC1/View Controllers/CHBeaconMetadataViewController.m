//
//  CHPointOfInterestViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHBeaconMetadataViewController.h"
#import "CHEnRouteViewController.h"


@interface CHBeaconMetadataViewController ()

@end

@implementation CHBeaconMetadataViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutMetadata];
}

- (void)layoutMetadata {
    
    self.currentBeaconDescriptionLabel.text = self.currentBeaconMetadata.locationDescription;
    self.metadataTextView.text = self.currentBeaconMetadata.locationInformation;
    
    // Setup the appropriate buttons
    if ([self.currentBeaconMetadata.name isEqualToString:BeaconB1]) {
        [self.nextActionButton setImage:[UIImage imageNamed:@"start-tour-btn"] forState:UIControlStateNormal];
        [self.nextActionButton setImage:[UIImage imageNamed:@"start-tour-btn-selected"] forState:UIControlStateSelected];
    } else if ([self.currentBeaconMetadata.name isEqualToString:BeaconB5]) {
        [self.nextActionButton setImage:[UIImage imageNamed:@"finish-tour-btn"] forState:UIControlStateNormal];
        [self.nextActionButton setImage:[UIImage imageNamed:@"finish-tour-btn-selected"] forState:UIControlStateSelected];
    } else {
        [self.nextActionButton setImage:[UIImage imageNamed:@"next-stop-btn"] forState:UIControlStateNormal];
        [self.nextActionButton setImage:[UIImage imageNamed:@"next-stop-btn-selected"] forState:UIControlStateSelected];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showEnRoute"]){
        CHEnRouteViewController *routeViewController = segue.destinationViewController;
        routeViewController.currentBeaconMetadata = self.currentBeaconMetadata;
    }
}

- (IBAction)nextActionButtonTapped:(id)sender {
    if([self.currentBeaconMetadata.name isEqualToString:BeaconB5]){
        [self performSegueWithIdentifier:@"showThanks" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"showEnRoute" sender:nil];
    }
}

@end
