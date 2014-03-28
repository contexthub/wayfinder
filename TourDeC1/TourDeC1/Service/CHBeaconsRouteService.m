//
//  CHRouteService.m
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import "CHBeaconsRouteService.h"
#import "CHBeaconMetadata.h"

@implementation CHBeaconsRouteService

typedef void (^ActiveRigCountSuccessBlock)(NSNumber *activeRigCount);
+ (CHBeaconsRouteService *)sharedService {
  static CHBeaconsRouteService * __sharedInstance = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSURL *baseURL = [NSURL URLWithString:@"http://tourdec1.herokuapp.com/api"];
    __sharedInstance = [[CHBeaconsRouteService alloc]initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    __sharedInstance.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
  });
  return __sharedInstance;
}

- (void)getAllBeaconsMetadata:(void(^)(NSArray *beacons))success andFailure:(void(^)(NSError *error))failure{
  [self GET:@"beacons" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"%@",responseObject);
    NSDictionary *responseData = (NSDictionary *)responseObject;
    NSArray *beacons = responseData[@"beacons"];
    NSMutableArray *parsedBeacons = [NSMutableArray array];
    for(NSDictionary *beaconData in beacons){
      CHBeaconMetadata *beacon = [[CHBeaconMetadata alloc]initWithData:beaconData];
      [parsedBeacons addObject:beacon];
    }
    success(parsedBeacons);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    failure(error);
  }];
}



@end
