//
//  CHPointOfInterestViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHBeaconMetadataViewController.h"
#import "CHEnRouteViewController.h"


@interface CHBeaconMetadataViewController ()

@end

@implementation CHBeaconMetadataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutMetada];
}

- (void)layoutMetada {
    NSLog(@"layout info string, and setup buttons");
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"showEnRoute"]){
    CHEnRouteViewController *routeViewController = segue.destinationViewController;
    routeViewController.currentBeaconMetadata = self.currentBeaconMetadata;
  }
}


- (IBAction)nextActionButtonTapped:(id)sender {
}
@end
