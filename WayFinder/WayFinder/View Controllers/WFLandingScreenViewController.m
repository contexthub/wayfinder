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
#import "WFGlobals.h"

@interface WFLandingScreenViewController ()

@end

@implementation WFLandingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Turn on notifications about beacons
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleEvent:)
                                                name:CCHContextEventManagerDidPostEvent
                                              object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    // Definitely make sure we get no more notifications about beacons (next screen will turn them on when needed)
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// Handles events from beacons
- (void)handleEvent:(NSNotification *)notification {
    WFBeaconMetadata *anyBeacon = [WFBeaconMetadata beaconFromNotification:notification];
        
    // At the landing screen, we only care we can detect the BeaconUUID (meaning we are somewhere near the office)
    if([anyBeacon.uuid isEqualToString:BeaconUdid]) {
        // Turn off notifications about beacons
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        [self performSegueWithIdentifier:@"showWelcomeScreen" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWelcomeScreen"]){
        // Set up the beacon info the welcome screen needs to know about (Beacon1)
        WFWelcomeViewController *welcomeVC = segue.destinationViewController;
        
        // Not currently at any specific beacon
        //welcomeVC.currentBeaconMetadata = nil;
        welcomeVC.destinationBeaconMetadata = [[WFBeaconStore sharedStore] firstBeacon];
    }
}

@end
