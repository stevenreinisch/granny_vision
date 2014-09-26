//
//  AppModule.m
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

#import "AppModule.h"

#import "P_WunderBarService.h"
#import "WunderBarService.h"
#import "WunderbarServiceStub.h"
#import "P_WunderbarConfig.h"
#import "WunderbarConfig.h"
#import "StartViewController.h"

@implementation AppModule

- (void)configure {
   
    [self //bindClass:[WunderBarService class]
          bindClass:[WunderbarServiceStub class]
         toProtocol:@protocol(P_WunderBarService)
            inScope:JSObjectionScopeSingleton];
    
    [self bindClass:[WunderbarConfig class]
         toProtocol:@protocol(P_WunderbarConfig)
            inScope:JSObjectionScopeSingleton];
    
    [self bindClass:[StartViewController class] inScope:JSObjectionScopeNormal];

}

@end
