//
//  ReviewViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // StatusBar setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // NaviBar setting
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    // MenuBtn setting
    [self.menuBtn1 setImage:[UIImage imageNamed:@"menu6.png"] forState:UIControlStateNormal];
    [self.menuBtn2 setImage:[UIImage imageNamed:@"menu2.png"] forState:UIControlStateNormal];
    [self.menuBtn3 setImage:[UIImage imageNamed:@"menu3.png"] forState:UIControlStateNormal];
    [self.menuBtn4 setImage:[UIImage imageNamed:@"menu4.png"] forState:UIControlStateNormal];
    
    //NaviBar fadeOut
    [self.shyNavBarManager setScrollView:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
