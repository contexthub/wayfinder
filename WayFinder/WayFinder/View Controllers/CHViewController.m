//
//  CHViewController.m
//  WayFinder
//
//  Created by Anuradha Ramprakash on 4/7/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHViewController.h"

@interface CHViewController ()

@end

@implementation CHViewController

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
