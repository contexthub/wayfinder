//
//  CHDeliRoomViewController.m
//  TourDeC1
//
//  Created by Joefrey Kibuule on 5/21/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHDeliRoomViewController.h"
#import "CHEnRouteViewController.h"

@interface CHDeliRoomViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentBeaconDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;

@end

@implementation CHDeliRoomViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutMetadata];
}

- (void)layoutMetadata {
    
    self.currentBeaconDescriptionLabel.text = self.currentBeaconMetadata.locationDescription;
    self.metadataTextView.text = self.currentBeaconMetadata.locationInformation;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showEnRoute3"]){
        CHEnRouteViewController *destinationVC = segue.destinationViewController;
        destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
    }
}

@end
