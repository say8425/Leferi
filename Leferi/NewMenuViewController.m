//
//  NewMenuViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 9. 15..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "NewMenuViewController.h"

@implementation NewMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // StatusBar setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // NaviBar setting
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    // MenuBtn setting
    [self.titleImageView setImage:[UIImage imageNamed:@"titleImage.png"]];
    [self.letterImageView setImage:[UIImage imageNamed:@"letterImage.png"]];
    [self.menuBtn1 setImage:[UIImage imageNamed:@"story1.png"] forState:UIControlStateNormal];
    [self.menuBtn2 setImage:[UIImage imageNamed:@"story2.png"] forState:UIControlStateNormal];
    [self.menuBtn3 setImage:[UIImage imageNamed:@"story3.png"] forState:UIControlStateNormal];
    [self.menuBtn4 setImage:[UIImage imageNamed:@"story4.png"] forState:UIControlStateNormal];
    
    //NaviBar fadeOut
    //[self.shyNavBarManager setScrollView:self.scrollView];
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


- (IBAction)btn2YouTube:(id)sender {
    NSString *Lancome = @"vFgD5-X7_zQ";
    //NSString *PSY = @"9bZkp7q19f0";
    
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:Lancome];
    [videoPlayerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
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
 