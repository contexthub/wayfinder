//
//  WFBeaconMetadataViewController.m
//  WayFinder
//
//  Created by Joefrey Kibuule on 5/22/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFBeaconMetadataViewController.h"

#import "WFEnRouteViewController.h"

#import "WFBeaconMetadata.h"
#import "WFBeaconStore.h"

@interface WFBeaconMetadataViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentBeaconDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;
@property (weak, nonatomic) IBOutlet UIButton *advanceTourButton;

@end


@implementation WFBeaconMetadataViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutMetadata];
}

#pragma mark - Layout

- (void)layoutMetadata {
    // Setup text
    self.currentBeaconDescriptionLabel.text = self.currentBeaconMetadata.locationDescription;
    self.metadataTextView.text = self.currentBeaconMetadata.locationInformation;
    
    WFBeaconMetadata *beacon = [[WFBeaconStore sharedStore] metadataForBeaconWithName:self.currentBeaconMetadata.identifier];
    
    // Setup buttons
    if (beacon) {
        if ([beacon isSameBeacon:[[WFBeaconStore sharedStore] lastBeacon]]) {
            [self.advanceTourButton setImage:[UIImage imageNamed:@"finish-tour-btn"] forState:UIControlStateNormal];
            [self.advanceTourButton setImage:[UIImage imageNamed:@"finish-tour-btn-selected"] forState:UIControlStateHighlighted];
        } else {
            [self.advanceTourButton setImage:[UIImage imageNamed:@"next-stop-btn"] forState:UIControlStateNormal];
            [self.advanceTourButton setImage:[UIImage imageNamed:@"next-stop-btn-selected"] forState:UIControlStateHighlighted];
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showEnRoute"]){
        WFEnRouteViewController *destinationVC = segue.destinationViewController;
        destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
    } else if([segue.identifier isEqualToString:@"showThanks"]){
        // Increment the number of times visited the office
        NSInteger timesVisited = [[[NSUserDefaults standardUserDefaults] objectForKey:@"timesVisited"] intValue];
        timesVisited++;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:(int)timesVisited] forKey:@"timesVisited"];
    }
}

#pragma mark - Actions

- (IBAction)advanceTour:(id)sender {
    WFBeaconMetadata *beacon = [[WFBeaconStore sharedStore] metadataForBeaconWithName:self.currentBeaconMetadata.identifier];
    
    // Last beacon means its the end of the tour
    if ([beacon isSameBeacon:[[WFBeaconStore sharedStore] lastBeacon]]) {
        [self performSegueWithIdentifier:@"showThanks" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"showEnRoute" sender:nil];
    }
}

@end
