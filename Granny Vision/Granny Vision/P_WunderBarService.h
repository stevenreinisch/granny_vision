//
//  P_WunderBarService.h
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

extern NSString *const kDoorBellIsRinning;

typedef enum {
    kCloudNotReachable
} WunderBarError;

@protocol P_WunderBarService <NSObject>

- (void)connect:(void (^)(NSError* error))completion;

@end
