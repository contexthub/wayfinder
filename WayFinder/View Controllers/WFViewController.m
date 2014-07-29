//
//  WFViewController.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/7/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "WFViewController.h"

@interface WFViewController ()
@end


@implementation WFViewController

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end