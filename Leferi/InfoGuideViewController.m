//
//  InfoGuideViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 24..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "InfoGuideViewController.h"

@interface InfoGuideViewController ()

@end

@implementation InfoGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NavBar Setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"InfoGuiteTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.scrollView];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
