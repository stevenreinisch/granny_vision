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
#import <Relayr/Relayr.h>

NSString *const kDoorBellIsRinning = @"kDoorBellIsRinning";
NSString *const kSantaIsComing = @"kSantaIsComing";

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

            self.app = [RelayrApp retrieveAppFromKeyChain:[config appID]];
	
            if (!self.app) {
                
                [RelayrApp appWithID:[config appID]
                   OAuthClientSecret:[config secretID]
                         redirectURI:[config redirectURI]
                          completion:^(NSError* error, RelayrApp* app){
                              
                              if (!error) {
                                  if (app) {
                                      NSLog(@"Application with name: %@ and description: %@", app.name, app.description);
                                      self.app = app;
                                      
                                      [app signInUser:^(NSError *error, RelayrUser *user) {
                                          
                                          if (!error) {
                                              [RelayrApp storeAppInKeyChain:app];
                                          }
                                          
                                          completion(error);
                                      }];
                                  }
                              } else {
                                  NSLog(@"Cannot connect to app %@", [config appID]);
                              }
                              completion(error);
                }];
            } else {
                NSLog(@"Found an app in the keychain");
                completion(nil);
            }
            
        } else {
            NSError *error = [NSError errorWithDomain:NSStringFromClass([self class])
                                                 code:kCloudNotReachable
                                             userInfo:nil];
            completion(error);
        }
    }];
}

- (BOOL)isConnected {
    return self.app != nil;
}

- (void)listDevices {
    if ([self isConnected]) {
        
        RelayrUser *user = self.app.loggedUsers.lastObject;
        
        [user queryCloudForIoTs:^(NSError* error){
            if (error) { return NSLog(@"%@", error.localizedDescription); }
            
            for (RelayrTransmitter* transmitter in user.transmitters)
            {
                NSLog(@"Transmitter's name: %@", transmitter.name);
            }
            
            for (RelayrDevice* device in user.devices)
            {
                NSLog(@"Device's name: %@", device.name);
                
                for (RelayrInput* reading in device.inputs)
                {
                    NSLog(@"This device can measure %@ in %@ units", reading.meaning, reading.unit);
                    NSLog(@"Last value obtained by this device for this specific reading is %@ at %@", reading.value, reading.date);
                }
            }
        }];
    }
}

@end
