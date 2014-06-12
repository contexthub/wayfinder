//
//  WFLandingScreenViewController.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFLandingScreenViewController.h"
#import "WFWelcomeViewController.h"
#import "WFBeaconStore.h"

@interface WFLandingScreenViewController ()

@end

@implementation WFLandingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if TARGET_IPHONE_SIMULATOR
    // Pop a notification that this app only works on actual devices
    [[[UIAlertView alloc] initWithTitle:@"Important!" message:@"This demo will only work using a real iOS device." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
#endif
    
    [WFBeaconStore sharedStore];
    
    // Turn on notifications about beacons
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleEvent:) name:CCHSensorPipelineDidPostEvent object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    // Definitely make sure we get no more notifications about beacons (next screen will turn them on when needed)
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CCHSensorPipelineDidPostEvent object:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWelcomeScreen"]){
        // Set up the beacon info the welcome screen needs to know about (Beacon1)
        WFWelcomeViewController *welcomeVC = segue.destinationViewController;
        
        // Not currently at any specific beacon
        //welcomeVC.currentBeaconMetadata = nil;
        welcomeVC.destinationBeaconMetadata = [[WFBeaconStore sharedStore] firstBeacon];
    }
}

#pragma mark - Events

// Handles events from beacons
- (void)handleEvent:(NSNotification *)notification {
    WFBeaconMetadata *anyBeacon = [WFBeaconMetadata beaconFromNotification:notification];
    
    // First check and make sure the notification event is from a beacon
    if (anyBeacon) {
        // Make sure we have beacons in the store (the ones we are interested in)
        if ([WFBeaconStore sharedStore].beacons.count > 0) {
            // At the landing screen, we only care we can detect the BeaconUUID (meaning we are somewhere near the office)
            if([anyBeacon.proximityUUID isEqual:[[WFBeaconStore sharedStore] firstBeacon].proximityUUID]) {
                // Turn off notifications about beacons
                [[NSNotificationCenter defaultCenter] removeObserver:self name:CCHSensorPipelineDidPostEvent object:nil];
                
                [self performSegueWithIdentifier:@"showWelcomeScreen" sender:nil];
            }
        }
    }
}


@end
