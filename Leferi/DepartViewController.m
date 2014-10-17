//
//  DepartViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 26..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "DepartViewController.h"

@interface DepartViewController ()

@end

@implementation DepartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //StatusBar Setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    //NavigationBar Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"departTitleBar.png"] forBarMetrics:UIBarMetricsDefault];  //titleBar
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]]; //backButton
    
    //WebView Setting
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.hyundaihmall.com/front/smItemDetailR.do?SectId=580895&ItemCode=2013030154"]]];
    [self.webView setDelegate:self];
    
    //WebView Loading //backView
    self.loadingView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 - 40,
                                                               ([[UIScreen mainScreen]bounds].size.height)/2 - 104 , 80, 80)];
    [self.loadingView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [self.loadingView.layer setCornerRadius:5];
    NSLog(@"%f", self.navigationController.navigationBar.frame.size.height);
    
    //WebView Loading //actiIcon
    self.actiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.actiView setCenter:CGPointMake(self.loadingView.frame.size.width / 2.0, self.loadingView.frame.size.height / 2.0)];
    [self.actiView startAnimating];
    [self.actiView setTag:100];
    [self.loadingView addSubview:self.actiView];
    
    [self.view addSubview:self.loadingView];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.webView withDelay:65];
}

#pragma mark - Web loading function
- (void)webViewDidStartLoad:(UIWebView*)webView {
    [self.loadingView setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView removeFromSuperview];
}

#pragma mark - NavigationBar Fade out - sub Function
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (IBAction)back:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [[self parentViewController] dismissModalViewControllerAnimated:YES];
//    self.parentViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    self.parentViewController.view.alpha = 0.0;
//    [UIView animateWithDuration:0.5
//                     animations:^{self.parentViewController.view.alpha  = 1.0;}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
