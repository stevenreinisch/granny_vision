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
    
    [RelayrCloud isReachable:^(NSError* error, NSNumber* isReachable){
        if (isReachable.boolValue) {
            NSLog(@"The Relayr Cloud is reachable!");
            
            [RelayrApp appWithID:[config appID]
               OAuthClientSecret:[config secretID]
                     redirectURI:[config redirectURI]
                      completion:^(NSError* error, RelayrApp* app){
                          
                          if (!error) {
                              if (app) {
                                  NSLog(@"Application with name: %@ and description: %@", app.name, app.description);
                                  self.app = app;
                              }
                          } else {
                              NSLog(@"Cannot connect to app %@", [config appID]);
                          }
                          completion(error);
            }];
            
        } else {
            NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                                 code:kCloudNotReachable
                                             userInfo:nil];
            completion(error);
        }
    }];
    
    
}

@end
