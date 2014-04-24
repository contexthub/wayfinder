//
//  CHViewController.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 4/7/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHViewController : UIViewController

- (NSUInteger)supportedInterfaceOrientations;
- (BOOL)shouldAutorotate;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (BOOL)isBeaconIn:(NSString *)eventName;
- (BOOL)isNearOrImmediateBeacon:(NSString *)eventName state:(NSString *)state; 
@end
