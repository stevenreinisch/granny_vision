//
//  ViewController.m
//  Granny Vision
//
//  Created by steffen on 26/09/14.
//  Copyright (c) 2014 hedonistic enthusiasts. All rights reserved.
//

#import "StartViewController.h"
#import "Objection.h"
#import "P_WunderBarService.h"
#import "P_MircoPhoneObserver.h"
#import "MBProgressHUD.h"
#import "TWMessageBarManager.h"


@interface StartViewController ()

@property (strong) id<P_WunderBarService> wunderBarService;
@property (strong) id<P_MircoPhoneObserver> micObserver;

@end

@implementation StartViewController

objection_requires(@"wunderBarService")
@synthesize wunderBarService;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wunderBarService = [[JSObjection defaultInjector] getObject:@protocol(P_WunderBarService)];
    self.micObserver = [[JSObjection defaultInjector] getObject:@protocol(P_MircoPhoneObserver)];
    [self.micObserver startObserving];
    [self _subscribeToNotifications];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Connecting to WunderBar";
    
    [self.wunderBarService connect:^(NSError *error) {
        [hud hide:YES];

        if (!error) {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Connected"
                                                           description:nil
                                                                  type:TWMessageBarMessageTypeSuccess
                                                              duration:2.0];
            
            [self.wunderBarService listDevices];
            
        } else {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Not Connected"
                                                           description:nil
                                                                  type:TWMessageBarMessageTypeError
                                                              duration:2.0];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void) _subscribeToNotifications {
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:kDoorBellIsRinning
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         
         [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Door bell is ringing"
                                                        description:nil
                                                               type:TWMessageBarMessageTypeInfo
                                                           duration:2.0];
     }];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:kSantaIsComing
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         
         [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Santa is coming to town!"
                                                        description:nil
                                                               type:TWMessageBarMessageTypeInfo
                                                           duration:2.0];
     }];
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:kUserBlowDetected
     object:nil
     queue:[NSOperationQueue mainQueue]
     usingBlock:^(NSNotification *note) {
         
         [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Blow it!"
                                                        description:nil
                                                               type:TWMessageBarMessageTypeInfo
                                                           duration:2.0];
     }];
}

@end
