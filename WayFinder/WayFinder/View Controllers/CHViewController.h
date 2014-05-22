//
//  CHViewController.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/7/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHViewController : UIViewController

@property (nonatomic, strong) CHBeaconMetadata *currentBeaconMetadata;          // This beacon
@property (nonatomic, strong) CHBeaconMetadata *destinationBeaconMetadata;      // The next beacon

- (NSUInteger)supportedInterfaceOrientations;
- (BOOL)shouldAutorotate;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end