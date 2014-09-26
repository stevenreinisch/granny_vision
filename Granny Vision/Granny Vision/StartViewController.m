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
        
        MBProgressHUD *completionHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        
        if (!error) {
            completionHUD.labelText = @"Es ist so wunderbar!";
        } else {
            completionHUD.labelText = @"Someone has eaten the bar!";
        }
        
        [completionHUD show:YES];
        [completionHUD hide:YES afterDelay:2];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
