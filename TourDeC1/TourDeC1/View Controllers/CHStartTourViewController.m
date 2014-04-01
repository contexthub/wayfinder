//
//  CHStartTourViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHStartTourViewController.h"

@interface CHStartTourViewController ()

@end

@implementation CHStartTourViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"startEnRoute"]){
        CHEnRouteViewController *destinationVC = segue.destinationViewController;
        destinationVC.currentBeaconMetadata = self.currentBeaconMetadata;
        [destinationVC setUserAtBeaconName:BeaconB1];
    }
}

@end
