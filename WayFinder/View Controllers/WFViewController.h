//
//  WFViewController.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/7/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

@class WFBeaconMetadata;

@interface WFViewController : UIViewController

@property (nonatomic, strong) WFBeaconMetadata *currentBeaconMetadata;          // This beacon
@property (nonatomic, strong) WFBeaconMetadata *destinationBeaconMetadata;      // The next beacon

- (NSUInteger)supportedInterfaceOrientations;
- (BOOL)shouldAutorotate;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end