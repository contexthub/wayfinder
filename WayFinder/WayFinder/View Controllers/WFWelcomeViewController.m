//
//  WFWelcomeViewController.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFWelcomeViewController.h"

@interface WFWelcomeViewController ()

@property (nonatomic, weak) IBOutlet UILabel *startTourPromptLabel;
@property (nonatomic, weak) IBOutlet UIButton *startTourButton;

@end

@implementation WFWelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleEvent:) name:CCHSensorPipelineDidPostEvent object:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    WFViewController *wfViewController = segue.destinationViewController;
    wfViewController.currentBeaconMetadata = self.destinationBeaconMetadata;
}

#pragma mark - Events

- (void)handleEvent:(NSNotification *)notification {
    // Grab the first beacon
    WFBeaconMetadata *firstBeacon = [[WFBeaconStore sharedStore] metadataForBeaconWithName:self.destinationBeaconMetadata.identifier];
    
    // Detect the first beacon for the lobby to show the "Start Tour" button
    if (firstBeacon) {
        if ([firstBeacon isSameBeaconFromNotification:notification inProximity:kBeaconProximityImmediate] || [firstBeacon isSameBeaconFromNotification:notification inProximity:kBeaconProximityNear]) {
            // Stop notifications
            [[NSNotificationCenter defaultCenter]removeObserver:self];
            
            self.startTourPromptLabel.hidden = YES;
            self.startTourButton.hidden = NO;
        }
    }
}

@end
