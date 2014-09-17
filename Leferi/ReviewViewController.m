//
//  ReviewViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 31..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ReviewViewController.h"

@implementation ReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"proposeTitle.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //WebView setting
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.reviewURL]];
    [self.webView setDelegate:self];
    NSLog(@"%@", self.urlString);
    
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
    [self followScrollView:self.webView withDelay:65];
}

//Web loading function
- (void)webViewDidStartLoad:(UIWebView*)webView {
    [self.loadingView setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView removeFromSuperview];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];  //transModal
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
