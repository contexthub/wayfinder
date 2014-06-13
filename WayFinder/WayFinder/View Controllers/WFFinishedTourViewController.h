//
//  WFFinishedTourViewController.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFViewController.h"

@interface WFFinishedTourViewController : WFViewController

@property (nonatomic, readwrite) NSInteger numTimesVisited;

@property (nonatomic, weak) IBOutlet UILabel *timesVisitedLabel;

@property (nonatomic, weak) IBOutlet UIImageView *prizeMarker1;
@property (nonatomic, weak) IBOutlet UIImageView *prizeMarker2;
@property (nonatomic, weak) IBOutlet UIImageView *prizeMarker3;
@property (nonatomic, weak) IBOutlet UIImageView *prizeMarker4;
@property (nonatomic, weak) IBOutlet UIImageView *prizeMarker5;

@end
