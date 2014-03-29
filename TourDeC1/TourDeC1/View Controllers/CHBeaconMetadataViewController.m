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
  if([self.currentBeaconMetadata.name isEqualToString:BeaconB1]){
    [self.currentBeaconDescriptionLabel setText:@"YOU'RE AT THE LOBBY"];
    [self.metadataTextView setText:@"ChaiOne is an Enterprise Mobility Agency focused on creating innovative, beautiful mobile solutions that solve complex business problems of large enterprises, with a specific focus on the energy industry."];
    [self.nextActionButton setImage:[UIImage imageNamed:@"next-stop-btn"] forState:UIControlStateNormal];
    [self.nextActionButton setImage:[UIImage imageNamed:@"next-stop-btn-selected"] forState:UIControlStateSelected];
  }
  else if([self.currentBeaconMetadata.name isEqualToString:BeaconB2]){
    [self.currentBeaconDescriptionLabel setText:@"YOU'RE AT THE IDEA WALL"];
    [self.metadataTextView setText:@"ChaiOne will open its headquartes in mid 2014. Take a look at the building’s renderings and explore some of our awesome ideas. We’re planning on having an awesome rooftop, a indoor pool, a zoo, and free beer 24/7."];
    [self.nextActionButton setImage:[UIImage imageNamed:@"next-stop-btn"] forState:UIControlStateNormal];
    [self.nextActionButton setImage:[UIImage imageNamed:@"next-stop-btn-selected"] forState:UIControlStateSelected];
  }
  else if([self.currentBeaconMetadata.name isEqualToString:BeaconB3]) {
    [self.currentBeaconDescriptionLabel setText:@"YOU'RE AT THE EXXON ROOM"];
    [self.metadataTextView setText:@"Exxon is one of our biggest clients. Our design and dev team spend their time happily working on this project. By 2015 the Exxon team will have produced 200 iOS and Android apps. Make sure to download them all!"];
    [self.nextActionButton setImage:[UIImage imageNamed:@"finish-tour-btn"] forState:UIControlStateNormal];
    [self.nextActionButton setImage:[UIImage imageNamed:@"finish-tour-btn-selected"] forState:UIControlStateSelected];
  }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.identifier isEqualToString:@"showEnRoute"]){
    CHEnRouteViewController *routeViewController = segue.destinationViewController;
    routeViewController.currentBeaconMetadata = self.currentBeaconMetadata;
  }
}


- (IBAction)nextActionButtonTapped:(id)sender {
  if([self.currentBeaconMetadata.name isEqualToString:BeaconB1] || [self.currentBeaconMetadata.name isEqualToString:BeaconB2]){
    [self performSegueWithIdentifier:@"showEnRoute" sender:nil];
  }
  else {
    [self performSegueWithIdentifier:@"showThanks" sender:nil];
  }
}
@end
