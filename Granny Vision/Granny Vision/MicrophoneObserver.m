//
//  MicrophoneObserver.m
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

#import "MicrophoneObserver.h"
#import "ARAudioRecognizer.h"
#import "ARAudioRecognizerDelegate.h"

NSString *const kUserBlowDetected = @"kUserBlowDetected";

@interface MicrophoneObserver () <ARAudioRecognizerDelegate>

@property (strong) ARAudioRecognizer* audioRecognizer;

@end

@implementation MicrophoneObserver

- (void)startObserving {
    self.audioRecognizer = [[ARAudioRecognizer alloc] initWithSensitivity:10.f frequency:40.f];
    self.audioRecognizer.delegate = self;
}

- (void)audioRecognized:(ARAudioRecognizer *)recognizer {
    NSLog(@"blow detected");
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserBlowDetected object:nil];
}

- (void)audioLevelUpdated:(ARAudioRecognizer *)recognizer level:(float)lowPassResults {
//    NSLog(@"audio level update: %2f", lowPassResults);
}

- (void)audioLevelUpdated:(ARAudioRecognizer *)recognizer averagePower:(float)averagePower peakPower:(float)peakPower {
//    NSLog(@"audio level update average power: %2f", averagePower);
//    NSLog(@"audio level update peak power: %2f", peakPower);
}

@end
