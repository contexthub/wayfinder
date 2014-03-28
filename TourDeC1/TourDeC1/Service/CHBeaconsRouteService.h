//
//  CHRouteService.h
//  TourDeC1
//
//  Created by Anuradha Ramprakash on 3/28/14.
//  Copyright (c) 2014 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"

@interface CHBeaconsRouteService : AFHTTPSessionManager
+ (CHBeaconsRouteService *)sharedService;
- (void)getAllBeaconsMetadata:(void(^)(NSArray *beacons))success andFailure:(void(^)(NSError *error))failure;
@end
