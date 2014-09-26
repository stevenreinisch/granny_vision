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
    
    [self.wunderBarService connect:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
