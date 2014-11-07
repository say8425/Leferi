//
//  ProvisionViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ProvisionViewController.h"

@interface ProvisionViewController ()

@end

@implementation ProvisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GoogleAnal Screen
    [self setScreenName:@"ProvisionView"];
    
    //NavBar Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ProvisionTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.scrollView];
    
    //If classic, then bagImage is changed whit classicStyle
    if ([[ETCLibrary getScreenPhysicalSize] isEqual:@"Classic/"]) [self.provisionBack setImage:[UIImage imageNamed:@"provisionBack_4S.png"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-  (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// This enables the user to scroll down the navbar by tapping the status bar.
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    [self showNavbar];
    return YES;
}

@end
