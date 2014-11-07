//
//  VersionViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "VersionViewController.h"

@interface VersionViewController ()

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GoogleAnal Screen
    [self setScreenName:@"VersionView"];

    // StatusBar setting
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //If classic, then bagImage is changed whit classicStyle
    if ([[ETCLibrary getScreenPhysicalSize] isEqual:@"Classic/"]) [self.versionBack setImage:[UIImage imageNamed:@"versionView4S.png"]];
    
    // Making Back Button
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(15, 24, 22, 37)];
    [backBtn setImage:[UIImage imageNamed:@"backButtonDS@2x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    [[self parentViewController] dismissViewControllerAnimated:YES completion:nil];
//    self.parentViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    self.parentViewController.view.alpha = 0.0;
//    [UIView animateWithDuration:0.5
//                     animations:^{self.parentViewController.view.alpha  = 1.0;}];    //[self dismissViewControllerAnimated:YES completion:nil];

//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController.navigationBar setHidden:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
