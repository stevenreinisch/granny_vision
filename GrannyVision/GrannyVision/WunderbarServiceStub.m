//
//  WunderbarServiceStub.m
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

#import "WunderbarServiceStub.h"

@interface WunderbarServiceStub ()

@property (strong) dispatch_queue_t queue;
@property (strong) dispatch_source_t timer;

@end

#pragma mark -

@implementation WunderbarServiceStub

- (void)connect:(void (^)(NSError* error))completion {
    
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        completion(nil);
        //completion([NSError errorWithDomain:@"" code:0 userInfo:nil]);
        
        self.queue = dispatch_queue_create("WunderbarServiceStubQ", 0);
        
        // create our timer source
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.queue);
        
        /*
         * - start after 2 seconds,
         * - repeat every X ms
         */
        dispatch_source_set_timer(self.timer,
                                  dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC),
                                  (5 * NSEC_PER_SEC),
                                  0);
        
        dispatch_source_set_event_handler(self.timer, ^{
            [self _generateEvent];
        });
        
        //dispatch_resume(self.timer);
    });
}

#pragma mark - private

- (void)_generateEvent {
    NSLog(@"WunderbarServiceStub is generating an event.");
    NSInteger randomNumber = arc4random() % 2;
    
    switch (randomNumber) {
        case 0: {
            [[NSNotificationCenter defaultCenter] postNotificationName:kDoorBellIsRinning object:nil];
        } break;
            
        case 1: {
            [[NSNotificationCenter defaultCenter] postNotificationName:kSantaIsComing object:nil];
        }break;
    }
    
}

@end
