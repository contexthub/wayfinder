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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"showEnRoute"]){
    CHEnRouteViewController *routeViewController = segue.destinationViewController;
    routeViewController.userAtBeaconName = self.currentBeaconMetadata.name;
  }
}


- (IBAction)nextActionButtonTapped:(id)sender {
}
@end
