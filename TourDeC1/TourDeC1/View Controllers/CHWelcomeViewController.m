//
//  CHWelcomeViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHWelcomeViewController.h"
#import "CHStartTourViewController.h"
#import "CGGlobals.h"

@interface CHWelcomeViewController ()

@property (nonatomic, weak) IBOutlet UILabel *startTourPromptLabel;
@property (nonatomic, weak) IBOutlet UIButton *startTourButton;

@end

@implementation CHWelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNextBeaconMetadata];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                          selector:@selector(handleEvent:)
                                              name:CCHContextEventManagerDidPostEvent
                                            object:nil];
}

- (void)loadNextBeaconMetadata {
    //self.destinationBeaconMetadata = [[CHBeaconStore sharedStore]metadataForBeaconWithName:BeaconB1];
}

- (void)handleEvent:(NSNotification *)notification {
    // Grab beacon 1
    CHBeaconMetadata *beacon1 = [[CHBeaconStore sharedStore] metadataForBeaconWithName:self.destinationBeaconMetadata.name];
    
    // Detect the next beacon for the lobby to show the "Start Tour" button
    if ([beacon1 isNearOrImmediateBeaconWithNotification:notification]) {
        // Stop notifications
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        
        self.startTourPromptLabel.hidden = YES;
        self.startTourButton.hidden = NO;
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CHViewController *chViewController = segue.destinationViewController;
    chViewController.currentBeaconMetadata = self.destinationBeaconMetadata;
}

@end
