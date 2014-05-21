//
//  CHProductRoomViewController.m
//  TourDeC1
//
//  Created by Joefrey Kibuule on 5/21/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHProductRoomViewController.h"
#import "CHEnRouteViewController.h"

@interface CHProductRoomViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentBeaconDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;

@end

@implementation CHProductRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutMetadata];
}

- (void)layoutMetadata {
    
    self.currentBeaconDescriptionLabel.text = self.currentBeaconMetadata.locationDescription;
    self.metadataTextView.text = self.currentBeaconMetadata.locationInformation;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showEnRoute2"]){
        CHEnRouteViewController *destinationVC = segue.destinationViewController;
        destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
    }
}

@end
