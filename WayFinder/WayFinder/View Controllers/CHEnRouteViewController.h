//
//  CHEnRouteViewController.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBeaconMetadata.h"

@interface CHEnRouteViewController : CHViewController

@property (weak, nonatomic) IBOutlet UIImageView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *navigationDirectionsImageView;
@property (weak, nonatomic) IBOutlet UILabel *directionsLabel;

@end
