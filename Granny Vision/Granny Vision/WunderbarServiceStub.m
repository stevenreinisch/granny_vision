//
//  WunderbarServiceStub.m
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

#import "WunderbarServiceStub.h"

@implementation WunderbarServiceStub

- (void)connect:(void (^)(NSError* error))completion {
    
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        completion(nil);
    });
}

@end
