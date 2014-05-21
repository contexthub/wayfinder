//
//  CHFinishedTourViewController.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHFinishedTourViewController.h"

@interface CHFinishedTourViewController ()

@end

@implementation CHFinishedTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numTimesVisited = 0;
    
}
- (void)viewWillAppear:(BOOL)animated {
    NSInteger timesVisited = [[[NSUserDefaults standardUserDefaults] objectForKey:@"timesVisited"] intValue];
    self.timesVisitedLabel.text = [NSString stringWithFormat:@"%ld time(s)", (long)timesVisited];
    
    switch(timesVisited) {
        case 1:
            self.prizeMarker1.image = [UIImage imageNamed:@"prize-marker-filled"];
            break;
        case 2:
            self.prizeMarker1.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker2.image = [UIImage imageNamed:@"prize-marker-filled"];
            break;
        case 3:
            self.prizeMarker1.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker2.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker3.image = [UIImage imageNamed:@"prize-marker-filled"];
            break;
        case 4:
            self.prizeMarker1.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker2.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker3.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker4.image = [UIImage imageNamed:@"prize-marker-filled"];
            break;
        case 5:
        default:
            self.prizeMarker1.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker2.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker3.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker4.image = [UIImage imageNamed:@"prize-marker-filled"];
            self.prizeMarker5.image = [UIImage imageNamed:@"prize-marker-filled"];
            break;
    }
}

@end
