//
//  WunderBarService.m
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

#import "WunderBarService.h"
#import "Objection.h"
#import "P_WunderbarConfig.h"
@import Relayr;

NSString *const kDoorBellIsRinning = @"kDoorBellIsRinning";

@interface WunderBarService ()
@property (strong) id<P_WunderbarConfig> config;
@property (strong) RelayrApp *app;
@end

@implementation WunderBarService

objection_requires(@"config")
@synthesize config;

- (void)connect:(void (^)(NSError* error))completion {
    NSLog(@"%@", [config appID]);
    completion(nil);
}

@end
