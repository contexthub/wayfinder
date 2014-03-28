//
//  CHAppDelegate.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHAppDelegate : UIResponder <UIApplicationDelegate>
+ (CHAppDelegate *) sharedAppDelegate;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *beaconsMetadata;
@end
