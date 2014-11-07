//
//  ReviewViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 31..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ReviewViewController.h"

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GoogleAnal Screen
    [self setScreenName:[NSString stringWithFormat:@"BlogView%ld", (long)self.reviewNum]];
    
    //NavBar Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"reviewTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];

    //WebView Setting
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.reviewURL]];
    [self.webView.scrollView setDelegate:self];
    [self.webView setDelegate:self];
    
    //WebView loading //backView
    self.loadingView = [[UIView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen]bounds].size.width/2 - 40,
                                                               [[UIScreen mainScreen]bounds].size.height/2 - 104, 80, 80)];
    [self.loadingView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    [self.loadingView.layer setCornerRadius:5];
    
    //loadingIcon
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
    [self followScrollView:self.webView];
}

#pragma mark - Web loading&stopping function
- (void)webViewDidStartLoad:(UIWebView*)webView {
    [self.webReload removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.webReload addTarget:self action:@selector(webStop:) forControlEvents:UIControlEventTouchUpInside];
    [self.webReload setImage:[UIImage imageNamed:@"webStop.png"] forState:UIControlStateNormal];
    [self.loadingView setHidden:NO];
    NSLog(@"webStart");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([webView canGoBack]) {
        [self.webBack setEnabled:YES];
        [self.webBack setAlpha:0.85f];
    } else {
        [self.webBack setEnabled:NO];
        [self.webBack setAlpha:0.24f];
    }
    
    if ([webView canGoForward]) {
        [self.webForward setEnabled:YES];
        [self.webForward setAlpha:0.85f];
    } else {
        [self.webForward setEnabled:NO];
        [self.webForward setAlpha:0.24f];
    }
    
    [self.webReload removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.webReload addTarget:self action:@selector(webReload:) forControlEvents:UIControlEventTouchUpInside];
    [self.webReload setImage:[UIImage imageNamed:@"webReload.png"] forState:UIControlStateNormal];
    [self.loadingView setHidden:YES];
    NSLog(@"webFinish");
}

-  (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NavigationBar Fade out - sub Function
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
    //[self stopFollowingScrollView];
}

// This enables the user to scroll down the navbar by tapping the status bar.
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    [self showNavbar];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebButton Action
- (IBAction)webBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)webForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)webReload:(id)sender {
    [self.webView reload];
    [self.webReload removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.webReload addTarget:self action:@selector(webStop:) forControlEvents:UIControlEventTouchUpInside];
    [self.webReload setImage:[UIImage imageNamed:@"webStop.png"] forState:UIControlStateNormal];
    [self.loadingView setHidden:NO];
    NSLog(@"webReload");
}

- (IBAction)webStop:(id)sender {
    [self.webView stopLoading];
    [self.webReload removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.webReload addTarget:self action:@selector(webReload:) forControlEvents:UIControlEventTouchUpInside];
    [self.webReload setImage:[UIImage imageNamed:@"webReload.png"] forState:UIControlStateNormal];
    [self.loadingView setHidden:YES];
    NSLog(@"webStop");
}
@end
