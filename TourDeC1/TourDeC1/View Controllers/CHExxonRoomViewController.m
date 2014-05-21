//
//  CHExxonRoomViewController.m
//  TourDeC1
//
//  Created by Joefrey Kibuule on 5/19/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHExxonRoomViewController.h"
#import "CHFinishedTourViewController.h"

@interface CHExxonRoomViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentBeaconDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *metadataTextView;

@end

@implementation CHExxonRoomViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showThanks"]){
        // Increment the number of times visited the office
        NSInteger timesVisited = [[[NSUserDefaults standardUserDefaults] objectForKey:@"timesVisited"] intValue];
        timesVisited++;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:(int)timesVisited] forKey:@"timesVisited"];
    }
}

@end
