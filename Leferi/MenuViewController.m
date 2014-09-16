//
//  MenuViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 18..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // StatusBar setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    // NaviBar setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    // MenuBtn setting
    [self.menuBtn1 setImage:[UIImage imageNamed:@"menu1.png"] forState:UIControlStateNormal];
    [self.menuBtn2 setImage:[UIImage imageNamed:@"menu2.png"] forState:UIControlStateNormal];
    [self.menuBtn3 setImage:[UIImage imageNamed:@"menu3.png"] forState:UIControlStateNormal];
    [self.menuBtn4 setImage:[UIImage imageNamed:@"menu4.png"] forState:UIControlStateNormal];
    [self.menuBtn5 setImage:[UIImage imageNamed:@"menu5.png"] forState:UIControlStateNormal];
    [self.menuBtn6 setImage:[UIImage imageNamed:@"menu6.png"] forState:UIControlStateNormal];
    [self.menuBtn7 setImage:[UIImage imageNamed:@"menu7.png"] forState:UIControlStateNormal];
    
    // SlideMenu setting
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SlideOutPanelController"];
    controller.preferredContentSize = CGSizeMake(320, 0);                           //widthSize
    slideOutPanelController = [controller viewControllerInPanelViewController];
    slideOutPanelController.tintColor = [UIColor colorWithWhite:0.91 alpha:0.12];   //tintColor
    slideOutPanelController.backgroundStyle = MCPanelBackgroundStyleCustomTint;

    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.scrollView withDelay:65];
}

// SlideMenu fadeOut subFunc
//- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController addGestureRecognizerToViewForScreenEdgeGestureWithPanelViewController:slideOutPanelController withDirection:MCPanelAnimationDirectionLeft];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [self.navigationController removeGestureRecognizersFromViewForScreenEdgeGestureWithPanelViewController:slideOutPanelController];
//    //[self showNavBarAnimated:NO];
//}


- (IBAction)slideBtn:(id)sender {
    [self.navigationController presentPanelViewController:slideOutPanelController withDirection:MCPanelAnimationDirectionLeft];
}

- (IBAction)btn2YouTube:(id)sender {
    NSString *Lancome = @"vFgD5-X7_zQ";
    //NSString *PSY = @"9bZkp7q19f0";
    
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:Lancome];
    [videoPlayerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

- (IBAction)btn7Facebook:(id)sender {
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"facebook://user?screen_name=lancomekorea"]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"facebook://user?screen_name=lancomekorea"]];
    } else {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.facebook.com/lancomekorea"]];
    }
}

//- (NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationPortrait;
//}

 

//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return NO;
//}

@end
