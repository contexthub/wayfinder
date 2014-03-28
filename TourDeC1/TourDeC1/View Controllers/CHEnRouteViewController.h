//
//  CHEnRouteViewController.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBeaconMetadata.h"

@interface CHEnRouteViewController : UIViewController
@property (nonatomic, strong) NSString *userAtBeaconName;
@property (weak, nonatomic) IBOutlet UIImageView *mapView;
@property (nonatomic, strong) CHBeaconMetadata *destinationBeaconMetadata;
@property (nonatomic, strong) CHBeaconMetadata *currentBeaconMetadata;
@property (weak, nonatomic) IBOutlet UIImageView *navigationDirectionsImageView;
@property (weak, nonatomic) IBOutlet UILabel *directionsLabel;

@end
