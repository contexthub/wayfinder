//
//  WFFinishedTourViewController.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFFinishedTourViewController.h"

@interface WFFinishedTourViewController ()

@end

@implementation WFFinishedTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numTimesVisited = 0;
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSInteger timesVisited = [[[NSUserDefaults standardUserDefaults] objectForKey:@"timesVisited"] intValue];
    self.timesVisitedLabel.text = [NSString stringWithFormat:@"%ld time(s)", (long)timesVisited];
    
    // Fills the appropriate number of logos based on the number of times visited
    NSArray *prizeMarkerImageViews = @[self.prizeMarker1, self.prizeMarker2, self.prizeMarker3, self.prizeMarker4, self.prizeMarker5];
    for (int i = 0; i < 5; i++) {
        ((UIImageView *)prizeMarkerImageViews[i]).image = [self setImageForPrizeMarker:i timesVisited:timesVisited];
    }
}

- (UIImage *)setImageForPrizeMarker:(NSInteger)index timesVisited:(NSInteger)timesVisited {
    if (index < timesVisited) {
        return [UIImage imageNamed:@"prize-marker-filled"];
    }
    
    return [UIImage imageNamed:@"prize-marker-empty"];
}

@end