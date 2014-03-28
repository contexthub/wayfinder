//
//  CHEnRouteViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHEnRouteViewController.h"
#import "CHAppDelegate.h"

@interface CHEnRouteViewController ()

@end

@implementation CHEnRouteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  //CHBeaconMetadata *currentBeacon = [self getCurrentBeaconMetadata];
}

//- (CHBeaconMetadata *)getCurrentBeaconMetadata {
//   NSArray *beaconsMetadata = [[CHAppDelegate sharedAppDelegate]beaconsMetadata];
//   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name like %@", self.userAtBeaconName];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
