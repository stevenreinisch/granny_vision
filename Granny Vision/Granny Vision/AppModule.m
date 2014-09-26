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
#import "StartViewController.h"

@implementation AppModule

- (void)configure {
   
    [self bindClass:[WunderBarService class]
         toProtocol:@protocol(P_WunderBarService)
            inScope:JSObjectionScopeSingleton];
    
    [self bindClass:[StartViewController class] inScope:JSObjectionScopeNormal];

}

@end
