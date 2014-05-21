//
//  CHIdeaWallViewController.m
//  TourDeC1
//
//  Created by Joefrey Kibuule on 5/19/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHIdeaWallViewController.h"
#import "CHEnRouteViewController.h"

@interface CHIdeaWallViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentBeaconDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;

@end

@implementation CHIdeaWallViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutMetadata];
}

- (void)layoutMetadata {
    
    self.currentBeaconDescriptionLabel.text = self.currentBeaconMetadata.locationDescription;
    self.metadataTextView.text = self.currentBeaconMetadata.locationInformation;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"startEnRoute2"]){
        CHEnRouteViewController *destinationVC = segue.destinationViewController;
        destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
    }
}

@end
