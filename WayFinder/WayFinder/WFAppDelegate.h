//
//  WFAppDelegate.h
//  WayFinder
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContextHub/ContextHub.h>

@interface WFAppDelegate : UIResponder <UIApplicationDelegate, CCHSensorPipelineDataSource, CCHSensorPipelineDelegate>
+ (WFAppDelegate *) sharedAppDelegate;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *beaconsMetadata;
@end
