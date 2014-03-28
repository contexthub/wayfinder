//
//  CHPointOfInterestViewController.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHAppDelegate.h"
#import "CHBeaconMetadata.h"

@interface CHBeaconMetadataViewController : UIViewController
@property (nonatomic,strong) CHBeaconMetadata *currentBeaconMetadata;
@property (weak, nonatomic) IBOutlet UIButton *nextActionButton;
@property (weak, nonatomic) IBOutlet UILabel *currentBeaconDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;

- (IBAction)nextActionButtonTapped:(id)sender;

@end
