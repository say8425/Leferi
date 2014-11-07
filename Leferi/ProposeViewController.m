//
//  ProposeViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 4..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ProposeViewController.h"

@interface ProposeViewController ()

@end

@implementation ProposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GoogleAnal Screen
    [self setScreenName:@"ProposeView"];

    //StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //NavigationBar Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"proposeTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //Cache Loading
    NSDictionary *pathPlist = [NSDictionary dictionaryWithContentsOfFile:[ETCLibrary getPath]];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:[pathPlist objectForKey:@"config"]];

    //Contents Setting
    [self.imageView setImage:[UIImage imageNamed:[pathPlist objectForKey:@"proposeStory"]]];
    [self.imageConstraintHeight setConstant:[[configDict objectForKey:@"proposeHeight"]floatValue]];   //Propose content - have to get height of image. imageHeight / 2 + 200
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.scrollView withDelay:65];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//

#pragma mark - NavigationBar Fade out - sub Function
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (IBAction)back:(id)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:[ETCLibrary getStatusBarFontColor]];
    [self performSegueWithIdentifier:@"backMenuFromPropose" sender:self];
    
}

@end
