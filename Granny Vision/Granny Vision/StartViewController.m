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
#import "MBProgressHUD.h"
#import "TWMessageBarManager.h"
@import Relayr;


@interface StartViewController ()

@property (strong) id<P_WunderBarService> wunderBarService;

@end

@implementation StartViewController

objection_requires(@"wunderBarService")
@synthesize wunderBarService;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wunderBarService = [[JSObjection defaultInjector] getObject:@protocol(P_WunderBarService)];
    
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

@end
